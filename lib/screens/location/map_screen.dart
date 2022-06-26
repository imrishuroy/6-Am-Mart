import '/helpers/dimensions.dart';
import '/models/address_model.dart';
import '/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:typed_data';
import 'dart:ui';

import 'address_details.dart';

class MapScreen extends StatefulWidget {
  final AddressModel address;
  final bool fromStore;
  const MapScreen({Key? key, required this.address, this.fromStore = false})
      : super(key: key);

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  LatLng? _latLng;
  Set<Marker> _markers = {};
  late GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    if (widget.address.latitude != null && widget.address.longitude != null) {
      _latLng = LatLng(double.parse(widget.address.latitude!),
          double.parse(widget.address.longitude!));
      _setMarker();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: CustomAppBar(title: 'location'.tr),
      //  endDrawer: MenuDrawer(),
      body: Center(
        child: SizedBox(
          width: Dimensions.webMaxWidth,
          child: Stack(children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(target: _latLng!, zoom: 17),
              zoomGesturesEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              indoorViewEnabled: true,
              markers: _markers,
              onMapCreated: (controller) => _mapController = controller,
            ),
            Positioned(
              left: Dimensions.paddingSizeLarge,
              right: Dimensions.paddingSizeLarge,
              bottom: Dimensions.paddingSizeLarge,
              child: InkWell(
                onTap: () {
                  if (_mapController != null) {
                    _mapController?.animateCamera(
                        CameraUpdate.newCameraPosition(
                            CameraPosition(target: _latLng!, zoom: 17)));
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radiusDefault),
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 3,
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: widget.fromStore
                      ? Text(
                          widget.address.address ?? 'N/A',
                          style: robotoMedium,
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Icon(
                                widget.address.addressType == 'home'
                                    ? Icons.home_outlined
                                    : widget.address.addressType == 'office'
                                        ? Icons.work_outline
                                        : Icons.location_on,
                                size: 30,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(
                                  width: Dimensions.paddingSizeSmall),
                              Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget.address.addressType ?? '',
                                        style: robotoRegular.copyWith(
                                          fontSize: 12.0,
                                          color:
                                              Theme.of(context).disabledColor,
                                        ),
                                      ),
                                      const SizedBox(
                                          height:
                                              Dimensions.paddingSizeExtraSmall),
                                      AddressDetails(
                                          addressDetails: widget.address),
                                    ]),
                              ),
                            ]),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            Text('- ${widget.address.contactPersonName}',
                                style: robotoMedium.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16.0,
                                )),
                            Text('- ${widget.address.contactPersonNumber}',
                                style: robotoRegular),
                          ],
                        ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void _setMarker() async {
    Uint8List destinationImageData = await convertAssetToUnit8List(
      widget.fromStore ? Images.restaurantMarker : Images.locationMarker,
      width: 120,
    );

    _markers = {};
    _markers.add(Marker(
      markerId: const MarkerId('marker'),
      position: _latLng!,
      icon: BitmapDescriptor.fromBytes(destinationImageData),
    ));

    setState(() {});
  }

  Future<Uint8List> convertAssetToUnit8List(String imagePath,
      {int width = 50}) async {
    ByteData data = await rootBundle.load(imagePath);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
