import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  void _onMapCreated(GoogleMapController? controller) {
    _mapController = controller;
  }

  void getCurrentLatLng() async {
    final position =
        await context.read<LocationRepository>().getCurrentPosition();
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });
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
                    pickedAddress: address ?? '', isEnabled: true,
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

                Positioned(
                  bottom: Dimensions.paddingSizeLarge,
                  left: Dimensions.paddingSizeSmall,
                  right: Dimensions.paddingSizeSmall,
                  child: CustomButton(
                    buttonText: 'Pick Address',
                    onPressed: () {},
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
