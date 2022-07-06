part of 'location_cubit.dart';

enum LocationStatus { initial, loading, succuss, error }

class LocationState extends Equatable {
  final Position position;
  final Position pickPosition;
  final bool loading;
  final String address;
  final String pickAddress;
  final List<Marker> markers;
  final List<AddressModel> addressList;
  final List<AddressModel> allAddressList;
  final int addressTypeIndex;
  final List<String> addressTypeList;
  final bool isLoading;
  final bool inZone;
  final int zoneID;
  final bool buttonDisabled;
  final bool changeAddress;
  final GoogleMapController? mapController;
  final List<PredictionModel> predictionList;
  final bool updateAddAddressData;
  final LocationStatus status;
  final Failure failure;

  const LocationState({
    required this.position,
    required this.pickPosition,
    required this.loading,
    required this.address,
    required this.pickAddress,
    required this.markers,
    required this.addressList,
    required this.allAddressList,
    required this.addressTypeIndex,
    required this.addressTypeList,
    required this.isLoading,
    required this.inZone,
    required this.zoneID,
    required this.buttonDisabled,
    required this.changeAddress,
    required this.mapController,
    required this.predictionList,
    required this.updateAddAddressData,
    required this.status,
    required this.failure,
  });

  factory LocationState.initial() => LocationState(
        position: Position(
          longitude: 0,
          latitude: 0,
          timestamp: DateTime.now(),
          accuracy: 1,
          altitude: 1,
          heading: 1,
          speed: 1,
          speedAccuracy: 1,
        ),
        pickPosition: Position(
          longitude: 0,
          latitude: 0,
          timestamp: DateTime.now(),
          accuracy: 1,
          altitude: 1,
          heading: 1,
          speed: 1,
          speedAccuracy: 1,
        ),
        loading: false,
        address: '',
        pickAddress: '',
        markers: const [],
        addressList: const [],
        allAddressList: const [],
        addressTypeIndex: 0,
        addressTypeList: const ['home', 'office', 'others'],
        isLoading: false,
        inZone: false,
        zoneID: 0,
        buttonDisabled: true,
        changeAddress: true,
        mapController: null,
        predictionList: const [],
        updateAddAddressData: true,
        status: LocationStatus.initial,
        failure: const Failure(),
      );

  @override
  List<Object?> get props {
    return [
      position,
      pickPosition,
      loading,
      address,
      pickAddress,
      markers,
      addressList,
      allAddressList,
      addressTypeIndex,
      addressTypeList,
      isLoading,
      inZone,
      zoneID,
      buttonDisabled,
      changeAddress,
      mapController,
      predictionList,
      updateAddAddressData,
      status,
      failure,
    ];
  }

  LocationState copyWith({
    Position? position,
    Position? pickPosition,
    bool? loading,
    String? address,
    String? pickAddress,
    List<Marker>? markers,
    List<AddressModel>? addressList,
    List<AddressModel>? allAddressList,
    int? addressTypeIndex,
    List<String>? addressTypeList,
    bool? isLoading,
    bool? inZone,
    int? zoneID,
    bool? buttonDisabled,
    bool? changeAddress,
    GoogleMapController? mapController,
    List<PredictionModel>? predictionList,
    bool? updateAddAddressData,
    LocationStatus? status,
    Failure? failure,
  }) {
    return LocationState(
      position: position ?? this.position,
      pickPosition: pickPosition ?? this.pickPosition,
      loading: loading ?? this.loading,
      address: address ?? this.address,
      pickAddress: pickAddress ?? this.pickAddress,
      markers: markers ?? this.markers,
      addressList: addressList ?? this.addressList,
      allAddressList: allAddressList ?? this.allAddressList,
      addressTypeIndex: addressTypeIndex ?? this.addressTypeIndex,
      addressTypeList: addressTypeList ?? this.addressTypeList,
      isLoading: isLoading ?? this.isLoading,
      inZone: inZone ?? this.inZone,
      zoneID: zoneID ?? this.zoneID,
      buttonDisabled: buttonDisabled ?? this.buttonDisabled,
      changeAddress: changeAddress ?? this.changeAddress,
      mapController: mapController ?? this.mapController,
      predictionList: predictionList ?? this.predictionList,
      updateAddAddressData: updateAddAddressData ?? this.updateAddAddressData,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  bool get stringify => true;
}
