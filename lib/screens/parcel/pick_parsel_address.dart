import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import '/repositories/location/location_repository.dart';
import '/utils/utils.dart';
import '/widgets/custom_button.dart';
import '/screens/location/widgets/search_location.dart';

import '/helpers/dimensions.dart';

class PickParcelAddress extends StatefulWidget {
  const PickParcelAddress({
    Key? key,
  }) : super(key: key);

  @override
  State<PickParcelAddress> createState() => _PickParcelAddressState();
}

class _PickParcelAddressState extends State<PickParcelAddress> {
  GoogleMapController? _mapController;
  CameraPosition? _cameraPosition;
  LatLng? _initialPosition;
  late BitmapDescriptor markerIcon;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId? selectedMarker;
  int _markerIdCounter = 1;

  void _addMarker({double? lat, double? long}) async {
    print('Market lat long - $lat , $long');
    final int markerCount = markers.length;

    if (markerCount == 12) {
      return;
    }
    _markerIdCounter++;
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    // _markerIdCounter++;

    //final MarkerId markerId = MarkerId(markerUID);
    // const int markerCount = 1;
    //markers.length;

    if (markerCount == 12) {
      return;
    }

    //LatLng(23.2486, 77.5022);
    final id = const Uuid().v4();
    final MarkerId markerId = MarkerId(id);
    final Marker marker = Marker(
      markerId: markerId,
      icon: await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(12, 12)), Images.pickMarker),
      // position: LatLng(
      //   lat ?? 23.2486 + sin(_markerIdCounter * pi / 6.0) / 20.0,
      //   lat ?? 777.5022 + cos(_markerIdCounter * pi / 6.0) / 20.0,
      // ),
      position: LatLng(lat ?? 23.2486, long ?? 77.5022),
      // center.latitude + sin(_markerIdCounter * pi / 6.0) / 20.0,
      // center.longitude + cos(_markerIdCounter * pi / 6.0) / 20.0,

      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () {},
      // _onMarkerTapped(markerId),
      // onDragEnd: (LatLng position) => _onMarkerDragEnd(markerId, position),
      // onDrag: (LatLng position) => _onMarkerDrag(markerId, position),
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  void _onMapCreated(GoogleMapController? controller) {
    _mapController = controller;
  }

  void getCurrentLatLng() async {
    final position =
        await context.read<LocationRepository>().getCurrentPosition();
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });
    if (_initialPosition != null) {
      getAddressFromGeocode(_initialPosition!);
    }

    // _addMarker(lat: position.latitude, long: position.longitude);
  }

  String? address;

  Future<void> getAddressFromGeocode(LatLng latLng) async {
    final locationRepo = context.read<LocationRepository>();
    final address = await locationRepo.getAddressFromLatLng(
      lat: latLng.latitude,
      lng: latLng.longitude,
    );
    print('Address from lat long -- $address');
    setState(() {
      this.address = address;
    });
  }

  @override
  void initState() {
    super.initState();
    // BitmapDescriptor.fromAssetImage(
    //         const ImageConfiguration(size: Size(50, 50)), Images.pickMarker)
    //     .then((onValue) {
    //   markerIcon = onValue;
    // });
    _onMapCreated(_mapController);
    getCurrentLatLng();

    // _onMapCreated(await GoogleMapController.init(id, initialCameraPosition, googleMapState))

    // _initialPosition = LatLng(
    //   double.parse(
    //       Get.find<SplashController>().configModel.defaultLocation.lat ?? '0'),
    //   double.parse(
    //       Get.find<SplashController>().configModel.defaultLocation.lng ?? '0'),
    // );
    //getCurrentLatLng_initialPosition = const LatLng(26.0, 44.0);

    // if (Get.find<SplashController>().configModel.module == null &&
    //     Get.find<SplashController>().moduleList == null) {
    //   Get.find<SplashController>().getModules();
    // }
  }

  @override
  Widget build(BuildContext context) {
    print('Initial postion - $_initialPosition');
    return Scaffold(
      // appBar: ResponsiveHelper.isDesktop(context) ? WebMenuBar() : null,
      ///  endDrawer: MenuDrawer(),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: Dimensions.webMaxWidth,
            child: Stack(
              children: [
                if (_initialPosition != null)
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: (_initialPosition!),
                      zoom: 17,
                    ),
                    // markers: Set<Marker>.of(markers.values),
                    myLocationButtonEnabled: false,
                    onMapCreated: _onMapCreated,
                    // if (!widget.fromAddAddress) {
                    //   Get.find<LocationController>().getCurrentLocation(false,
                    //       mapController: mapController);
                    // }
                    // },
                    // scrollGesturesEnabled: !Get.isDialogOpen,
                    zoomControlsEnabled: false,
                    onCameraMove: (CameraPosition cameraPosition) {
                      print(
                          'Camera postion on idle --- ${_cameraPosition?.target}');
                      _cameraPosition = cameraPosition;
                      print(
                          'Camera postion on moving --- ${_cameraPosition?.target}');
                    },
                    onCameraMoveStarted: () {
                      //locationController.disableButton();
                    },
                    onCameraIdle: () {
                      print(
                          'Camera postion on idle --- ${_cameraPosition?.target}');
                      if (_cameraPosition?.target != null) {
                        getAddressFromGeocode(_cameraPosition!.target);
                      }

                      // Get.find<LocationController>()
                      //     .updatePosition(_cameraPosition, false);
                    },
                  ),
                Center(
                  child: _initialPosition != null
                      ? Image.asset(Images.pickMarker, height: 50, width: 50)
                      : const CircularProgressIndicator(),
                ),
                Positioned(
                  top: Dimensions.paddingSizeLarge,
                  left: Dimensions.paddingSizeLarge,
                  right: Dimensions.paddingSizeLarge,
                  child: SearchLocationWidget(
                    mapController: _mapController,
                    // pickedAddress: locationController.pickAddress,
                    pickedAddress: address, isEnabled: true,
                    hint: 'Search your place',
                  ),
                ),
                Positioned(
                  bottom: 80,
                  right: Dimensions.paddingSizeSmall,
                  child: FloatingActionButton(
                      mini: true,
                      backgroundColor: Theme.of(context).cardColor,
                      onPressed: () async {
                        //getCurrentLatLng();
                        _mapController?.animateCamera(
                            CameraUpdate.newLatLng(_initialPosition!));
                      },
                      child: Icon(
                        Icons.my_location,
                        color: Theme.of(context).primaryColor,
                      )
                      // () =>
                      //     Get.find<LocationController>().checkPermission(() {
                      //   Get.find<LocationController>().getCurrentLocation(false,
                      //       mapController: _mapController);
                      // }),
                      ),
                ),
                if (address != null)
                  Positioned(
                    bottom: Dimensions.paddingSizeLarge,
                    left: Dimensions.paddingSizeSmall,
                    right: Dimensions.paddingSizeSmall,
                    child: CustomButton(
                      buttonText: 'Pick Address',
                      onPressed: () {
                        if (address != null) {
                          Navigator.of(context).pop(address);
                        }
                      },
                    ),
                  )

                // Positioned(
                //   bottom: Dimensions.paddingSizeLarge,
                //   left: Dimensions.paddingSizeSmall,
                //   right: Dimensions.paddingSizeSmall,
                //   child: !locationController.isLoading
                //       ?

                //        CustomButton(
                //           buttonText: locationController.inZone
                //               ? widget.fromAddAddress
                //                   ? 'pick_address'.tr
                //                   : 'pick_location'.tr
                //               : 'service_not_available_in_this_area'.tr,
                //           onPressed: (locationController.buttonDisabled ||
                //                   locationController.loading)
                //               ? null
                //               : () {
                //                   if (locationController
                //                               .pickPosition.latitude !=
                //                           0 &&
                //                       locationController
                //                           .pickAddress.isNotEmpty) {
                //                     if (widget.onPicked != null) {
                //                       AddressModel _address = AddressModel(
                //                         latitude: locationController
                //                             .pickPosition.latitude
                //                             .toString(),
                //                         longitude: locationController
                //                             .pickPosition.longitude
                //                             .toString(),
                //                         addressType: 'others',
                //                         address: locationController.pickAddress,
                //                         contactPersonName: locationController
                //                             .getUserAddress()
                //                             .contactPersonName,
                //                         contactPersonNumber: locationController
                //                             .getUserAddress()
                //                             .contactPersonNumber,
                //                       );
                //                       widget.onPicked(_address);
                //                       Get.back();
                //                     } else if (widget.fromAddAddress) {
                //                       if (widget.googleMapController != null) {
                //                         widget.googleMapController.moveCamera(
                //                             CameraUpdate.newCameraPosition(
                //                                 CameraPosition(
                //                                     target: LatLng(
                //                                       locationController
                //                                           .pickPosition
                //                                           .latitude,
                //                                       locationController
                //                                           .pickPosition
                //                                           .longitude,
                //                                     ),
                //                                     zoom: 17)));
                //                         locationController.setAddAddressData();
                //                       }
                //                       Get.back();
                //                     } else {
                //                       AddressModel _address = AddressModel(
                //                         latitude: locationController
                //                             .pickPosition.latitude
                //                             .toString(),
                //                         longitude: locationController
                //                             .pickPosition.longitude
                //                             .toString(),
                //                         addressType: 'others',
                //                         address: locationController.pickAddress,
                //                       );
                //                       locationController.saveAddressAndNavigate(
                //                         _address,
                //                         widget.fromSignUp,
                //                         widget.route,
                //                         widget.canRoute,
                //                         ResponsiveHelper.isDesktop(context),
                //                       );
                //                     }
                //                   } else {
                //                     showCustomSnackBar('pick_an_address'.tr);
                //                   }
                //                 },
                //         )
                //       : const  Center(child: CircularProgressIndicator()),
                // ),
              ],
            ),

            // GetBuilder<LocationController>(builder: (locationController) {
            //   /*print('--------------${'${locationController.pickPlaceMark.name ?? ''} '
            //       '${locationController.pickPlaceMark.locality ?? ''} '
            //       '${locationController.pickPlaceMark.postalCode ?? ''} ${locationController.pickPlaceMark.country ?? ''}'}');*/

            //   return
            // }),
          ),
        ),
      ),
    );
  }
}
