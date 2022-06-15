// import 'package:flutter/material.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import '/helpers/dimensions.dart';
// import '/models/address_model.dart';

// import 'widgets/search_location.dart';

// class PickMapScreen extends StatefulWidget {
//   final bool fromSignUp;
//   final bool fromAddAddress;
//   final bool canRoute;
//   final String route;
//   final GoogleMapController? googleMapController;
//   final Function(AddressModel? address)? onPicked;
//   const PickMapScreen({
//     Key? key,
//     required this.fromSignUp,
//     required this.fromAddAddress,
//     required this.canRoute,
//     required this.route,
//     this.googleMapController,
//     this.onPicked,
//   }) : super(key: key);

//   @override
//   State<PickMapScreen> createState() => _PickMapScreenState();
// }

// class _PickMapScreenState extends State<PickMapScreen> {
//   GoogleMapController? _mapController;
//   // CameraPosition? _cameraPosition;
//   // LatLng? _initialPosition = LatLng(26.0, 44.0);

//   void _onMapCreated(GoogleMapController? controller) {
//     _mapController = controller;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _onMapCreated(_mapController);

//     // _onMapCreated(await GoogleMapController.init(id, initialCameraPosition, googleMapState))

//     if (widget.fromAddAddress) {
//       //Get.find<LocationController>().setPickData();
//     }
//     // _initialPosition = LatLng(
//     //   double.parse(
//     //       Get.find<SplashController>().configModel.defaultLocation.lat ?? '0'),
//     //   double.parse(
//     //       Get.find<SplashController>().configModel.defaultLocation.lng ?? '0'),
//     // );
//     _initialPosition = const LatLng(26.0, 44.0);

//     // if (Get.find<SplashController>().configModel.module == null &&
//     //     Get.find<SplashController>().moduleList == null) {
//     //   Get.find<SplashController>().getModules();
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: ResponsiveHelper.isDesktop(context) ? WebMenuBar() : null,
//       ///  endDrawer: MenuDrawer(),
//       body: SafeArea(
//         child: Center(
//           child: SizedBox(
//             width: Dimensions.webMaxWidth,
//             child: Stack(
//               children: [
//                 GoogleMap(
//                   initialCameraPosition: const CameraPosition(
//                     target: (LatLng(26.643, 84.9040)),
//                     // target: widget.fromAddAddress
//                     //     ? LatLng(locationController.position.latitude,
//                     //         locationController.position.longitude)
//                     //     : _initialPosition,
//                     zoom: 17,
//                   ),
//                   // myLocationButtonEnabled: false,
//                   onMapCreated: _onMapCreated,
//                   // if (!widget.fromAddAddress) {
//                   //   Get.find<LocationController>().getCurrentLocation(false,
//                   //       mapController: mapController);
//                   // }
//                   // },
//                   // scrollGesturesEnabled: !Get.isDialogOpen,
//                   //zoomControlsEnabled: false,
//                   // onCameraMove: (CameraPosition cameraPosition) {
//                   //   _cameraPosition = cameraPosition;
//                   // },
//                   // onCameraMoveStarted: () {
//                   // locationController.disableButton();
//                   //},
//                   // onCameraIdle: () {
//                   //   // Get.find<LocationController>()
//                   //   //     .updatePosition(_cameraPosition, false);
//                   // },
//                 ),
//                 // Center(
//                 //     child: !locationController.loading
//                 //         ? Image.asset(Images.pick_marker, height: 50, width: 50)
//                 // //         : CircularProgressIndicator()),
//                 Positioned(
//                   top: Dimensions.paddingSizeLarge,
//                   left: Dimensions.paddingSizeLarge,
//                   right: Dimensions.paddingSizeLarge,
//                   child: SearchLocationWidget(
//                     mapController: _mapController,
//                     // pickedAddress: locationController.pickAddress,
//                     pickedAddress: 'Picked address', isEnabled: false,
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 80,
//                   right: Dimensions.paddingSizeSmall,
//                   child: FloatingActionButton(
//                       mini: true,
//                       backgroundColor: Theme.of(context).cardColor,
//                       onPressed: () {},
//                       child: Icon(
//                         Icons.my_location,
//                         color: Theme.of(context).primaryColor,
//                       )
//                       // () =>
//                       //     Get.find<LocationController>().checkPermission(() {
//                       //   Get.find<LocationController>().getCurrentLocation(false,
//                       //       mapController: _mapController);
//                       // }),
//                       ),
//                 ),
//                 // Positioned(
//                 //   bottom: Dimensions.paddingSizeLarge,
//                 //   left: Dimensions.paddingSizeSmall,
//                 //   right: Dimensions.paddingSizeSmall,
//                 //   child: !locationController.isLoading
//                 //       ?

//                 //        CustomButton(
//                 //           buttonText: locationController.inZone
//                 //               ? widget.fromAddAddress
//                 //                   ? 'pick_address'.tr
//                 //                   : 'pick_location'.tr
//                 //               : 'service_not_available_in_this_area'.tr,
//                 //           onPressed: (locationController.buttonDisabled ||
//                 //                   locationController.loading)
//                 //               ? null
//                 //               : () {
//                 //                   if (locationController
//                 //                               .pickPosition.latitude !=
//                 //                           0 &&
//                 //                       locationController
//                 //                           .pickAddress.isNotEmpty) {
//                 //                     if (widget.onPicked != null) {
//                 //                       AddressModel _address = AddressModel(
//                 //                         latitude: locationController
//                 //                             .pickPosition.latitude
//                 //                             .toString(),
//                 //                         longitude: locationController
//                 //                             .pickPosition.longitude
//                 //                             .toString(),
//                 //                         addressType: 'others',
//                 //                         address: locationController.pickAddress,
//                 //                         contactPersonName: locationController
//                 //                             .getUserAddress()
//                 //                             .contactPersonName,
//                 //                         contactPersonNumber: locationController
//                 //                             .getUserAddress()
//                 //                             .contactPersonNumber,
//                 //                       );
//                 //                       widget.onPicked(_address);
//                 //                       Get.back();
//                 //                     } else if (widget.fromAddAddress) {
//                 //                       if (widget.googleMapController != null) {
//                 //                         widget.googleMapController.moveCamera(
//                 //                             CameraUpdate.newCameraPosition(
//                 //                                 CameraPosition(
//                 //                                     target: LatLng(
//                 //                                       locationController
//                 //                                           .pickPosition
//                 //                                           .latitude,
//                 //                                       locationController
//                 //                                           .pickPosition
//                 //                                           .longitude,
//                 //                                     ),
//                 //                                     zoom: 17)));
//                 //                         locationController.setAddAddressData();
//                 //                       }
//                 //                       Get.back();
//                 //                     } else {
//                 //                       AddressModel _address = AddressModel(
//                 //                         latitude: locationController
//                 //                             .pickPosition.latitude
//                 //                             .toString(),
//                 //                         longitude: locationController
//                 //                             .pickPosition.longitude
//                 //                             .toString(),
//                 //                         addressType: 'others',
//                 //                         address: locationController.pickAddress,
//                 //                       );
//                 //                       locationController.saveAddressAndNavigate(
//                 //                         _address,
//                 //                         widget.fromSignUp,
//                 //                         widget.route,
//                 //                         widget.canRoute,
//                 //                         ResponsiveHelper.isDesktop(context),
//                 //                       );
//                 //                     }
//                 //                   } else {
//                 //                     showCustomSnackBar('pick_an_address'.tr);
//                 //                   }
//                 //                 },
//                 //         )
//                 //       : const  Center(child: CircularProgressIndicator()),
//                 // ),
//               ],
//             ),

//             // GetBuilder<LocationController>(builder: (locationController) {
//             //   /*print('--------------${'${locationController.pickPlaceMark.name ?? ''} '
//             //       '${locationController.pickPlaceMark.locality ?? ''} '
//             //       '${locationController.pickPlaceMark.postalCode ?? ''} ${locationController.pickPlaceMark.country ?? ''}'}');*/

//             //   return
//             // }),
//           ),
//         ),
//       ),
//     );
//   }
// }
