import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/models/response_model.dart';
import '/blocs/config/app_config_bloc.dart';
import '/models/zone_response.dart';
import '/models/address_model.dart';
import '/models/failure.dart';
import '/models/prediction_model.dart';
import '/repositories/location/location_repository.dart';
part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationRepository _locationRepository;
  final AppConfigBloc _configBloc;

  LocationCubit({
    required LocationRepository locationRepository,
    required AppConfigBloc configBloc,
  })  : _locationRepository = locationRepository,
        _configBloc = configBloc,
        super(LocationState.initial());

  Future<AddressModel> getCurrentLocation(
    bool fromAddress, {
    required GoogleMapController? mapController,
    LatLng? defaultLatLng,
    bool notify = true,
  }) async {
    emit(state.copyWith(loading: true));
    // _loading = true;
    if (notify) {
      //update();
    }
    AddressModel _addressModel;
    Position _myPosition;
    try {
      Position newLocalData = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _myPosition = newLocalData;
    } catch (e) {
      _myPosition = Position(
        latitude: defaultLatLng != null
            ? defaultLatLng.latitude
            : double.parse(
                _configBloc.state.configModel?.defaultLocation.lat ?? '0',
              ),
        longitude: defaultLatLng != null
            ? defaultLatLng.longitude
            : double.parse(
                _configBloc.state.configModel?.defaultLocation.lng ?? '0'),
        timestamp: DateTime.now(),
        accuracy: 1,
        altitude: 1,
        heading: 1,
        speed: 1,
        speedAccuracy: 1,
      );
    }
    if (fromAddress) {
      emit(state.copyWith(position: _myPosition));
    } else {
      emit(state.copyWith(pickPosition: _myPosition));
    }
    if (mapController != null) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(_myPosition.latitude, _myPosition.longitude),
            zoom: 17),
      ));
    }
    String addressFromGeocode = await getAddressFromGeocode(
        LatLng(_myPosition.latitude, _myPosition.longitude));
    fromAddress
        ? emit(state.copyWith(address: addressFromGeocode))
        : emit(state.copyWith(pickAddress: addressFromGeocode));

    ZoneResponseModel responseModel = await getZone(
        _myPosition.latitude.toString(),
        _myPosition.longitude.toString(),
        true);
    emit(state.copyWith(buttonDisabled: responseModel.isSuccess));

    _addressModel = AddressModel(
      latitude: _myPosition.latitude.toString(),
      longitude: _myPosition.longitude.toString(),
      addressType: 'others',
      zoneId: (responseModel.isSuccess ?? false) ? responseModel.zoneIds[0] : 0,
      zoneIds: responseModel.zoneIds,
      address: addressFromGeocode,
    );
    //   _loading = false;
    //   update();
    return _addressModel;
  }

  Future<ZoneResponseModel> getZone(
      String lat, String long, bool markerLoad) async {
    if (markerLoad) {
      emit(state.copyWith(loading: true));
    } else {
      emit(state.copyWith(isLoading: true));
    }

    ZoneResponseModel responseModel;
    Response response = await _locationRepository.getZone(lat, long);
    if (response.statusCode == 200) {
      emit(state.copyWith(
          inZone: true,
          zoneID:
              int.parse(jsonDecode(response.data['zone_id'])[0].toString())));

      List<int> _zoneIds = [];
      jsonDecode(response.data['zone_id']).forEach((zoneId) {
        _zoneIds.add(int.parse(zoneId.toString()));
      });
      responseModel =
          ZoneResponseModel(isSuccess: true, zoneIds: _zoneIds, message: '');
    } else {
      emit(state.copyWith(inZone: false));

      responseModel = ZoneResponseModel(
          isSuccess: false,
          zoneIds: [],
          message: response.statusMessage ?? 'Something went wrong');
      emit(state.copyWith(
        inZone: false,
      ));
    }
    if (markerLoad) {
      emit(state.copyWith(loading: false));
    } else {
      emit(state.copyWith(isLoading: false));
    }

    return responseModel;
  }

  Future<String> getAddressFromGeocode(LatLng latLng) async {
    Response response = await _locationRepository.getAddressFromGeocode(latLng);
    String address = 'Unknown Location Found';
    // if (response.statusCode == 200 && response.data['status'] == 'OK') {
    if (response.statusCode == 200) {
      address = response.data['results'][0]['formatted_address'].toString();
    } else {
      //  showCustomSnackBar(response.body['error_message'] ?? response.bodyString);
    }
    return address;
  }

  void setUpdateAddress(AddressModel address) {
    emit(
      state.copyWith(
        position: Position(
          latitude: double.parse(address.latitude ?? ''),
          longitude: double.parse(address.longitude ?? ''),
          timestamp: DateTime.now(),
          altitude: 1,
          heading: 1,
          speed: 1,
          speedAccuracy: 1,
          floor: 1,
          accuracy: 1,
        ),
        address: address.address,
        addressTypeIndex:
            state.addressTypeList.indexOf(address.addressType ?? ''),
      ),
    );
  }

  void setMapController(GoogleMapController mapController) {
    emit(state.copyWith(mapController: mapController));
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (state.updateAddAddressData) {
      emit(state.copyWith(loading: true));

      try {
        if (fromAddress) {
          emit(state.copyWith(
              position: Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            heading: 1,
            accuracy: 1,
            altitude: 1,
            speedAccuracy: 1,
            speed: 1,
          )));
        } else {
          emit(
            state.copyWith(
              pickPosition: Position(
                latitude: position.target.latitude,
                longitude: position.target.longitude,
                timestamp: DateTime.now(),
                heading: 1,
                accuracy: 1,
                altitude: 1,
                speedAccuracy: 1,
                speed: 1,
              ),
            ),
          );
        }
        ZoneResponseModel responseModel = await getZone(
          position.target.latitude.toString(),
          position.target.longitude.toString(),
          true,
        );
        emit(state.copyWith(
            buttonDisabled: !(responseModel.isSuccess ?? false)));

        if (state.changeAddress) {
          String addressFromGeocode = await getAddressFromGeocode(
              LatLng(position.target.latitude, position.target.longitude));
          fromAddress
              ? emit(state.copyWith(address: addressFromGeocode))
              : emit(state.copyWith(pickAddress: addressFromGeocode));
        } else {
          emit(state.copyWith(changeAddress: true));
        }
      } catch (e) {
        print('Error $e');
      }
      emit(state.copyWith(loading: false));
    } else {
      emit(state.copyWith(updateAddAddressData: true));
    }
  }

  Future<void> getAddressList() async {
    Response response = await _locationRepository.getAllAddress();

    if (response.statusCode == 200) {
      emit(state.copyWith(addressList: [], allAddressList: []));

      response.data.forEach((address) {
        emit(
          state.copyWith(
              addressList: List.from(state.addressList)
                ..add(AddressModel.fromMap(address)),
              allAddressList: List.from(state.allAddressList)
                ..add(AddressModel.fromMap(address))),
        );
      });
    } else {
      //ApiChecker.checkApi(response);
    }
    // update();
  }

  Future<ResponseModel> deleteUserAddressByID(int id, int index) async {
    Response response = await _locationRepository.removeAddressByID(id);
    ResponseModel _responseModel;
    if (response.statusCode == 200) {
      emit(state.copyWith(
          addressList: List.from(state.addressList)..removeAt(index)));

      _responseModel =
          ResponseModel(isSuccess: true, message: response.data['message']);
    } else {
      _responseModel = ResponseModel(
          isSuccess: false,
          message: response.statusMessage ?? 'Something went wrong');
    }
    // update();
    return _responseModel;
  }
}
