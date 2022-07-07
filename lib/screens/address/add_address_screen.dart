import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/blocs/user/user_cubit.dart';
import '/blocs/auth/auth_bloc.dart';
import '/blocs/config/app_config_bloc.dart';
import '/blocs/location/location_cubit.dart';
import '/helpers/dimensions.dart';
import '/translations/locale_keys.g.dart';
import '/utils/utils.dart';
import '/widgets/custom_appbar.dart';
import '/widgets/not_login_screen.dart';

import '/models/address_model.dart';

class AddAddressArgs {
  final bool fromCheckout;
  final AddressModel? address;

  const AddAddressArgs({
    required this.fromCheckout,
    this.address,
  });
}

class AddAddressScreen extends StatefulWidget {
  static const String routeName = 'addAddress';

  static Route route({required AddAddressArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => AddAddressScreen(
        fromCheckout: args.fromCheckout,
        address: args.address,
      ),
    );
  }

  final bool fromCheckout;
  final AddressModel? address;
  const AddAddressScreen({Key? key, required this.fromCheckout, this.address})
      : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonNameController =
      TextEditingController();
  final TextEditingController _contactPersonNumberController =
      TextEditingController();
  final TextEditingController _streetNumberController = TextEditingController();
  final TextEditingController _houseController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final FocusNode _addressNode = FocusNode();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _numberNode = FocusNode();
  final FocusNode _streetNode = FocusNode();
  final FocusNode _houseNode = FocusNode();
  final FocusNode _floorNode = FocusNode();
  bool isLoggedIn = false;
  CameraPosition? cameraPosition;
  LatLng? initialPosition;

  @override
  void initState() {
    super.initState();
    final configBloc = context.read<AppConfigBloc>();

    isLoggedIn = context.read<AuthBloc>().state.isLoggedIn();
    if (isLoggedIn && context.read<UserCubit>().state.user == null) {
      context.read<UserCubit>().getUserInfo();
    }
    if (widget.address == null) {
      initialPosition = LatLng(
          double.parse(
              configBloc.state.configModel?.defaultLocation.lat ?? '0'),
          double.parse(
              configBloc.state.configModel?.defaultLocation.lng ?? '0'));
    } else {
      if (widget.address != null) {
        context.read<LocationCubit>().setUpdateAddress(widget.address!);
        initialPosition = LatLng(
          double.parse(widget.address?.latitude ?? '0'),
          double.parse(widget.address?.longitude ?? '0'),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();
    final locationCubit = context.read<LocationCubit>();
    return Scaffold(
      appBar: CustomAppBar(
          title: widget.address == null
              ? LocaleKeys.add_new_address.tr()
              : LocaleKeys.update_address.tr()),
      body: isLoggedIn
          ? BlocConsumer<UserCubit, UserState>(
              listener: (context, state) {},
              builder: ((context, state) {
                if (widget.address != null) {
                  if (_contactPersonNameController.text.isEmpty) {
                    _contactPersonNameController.text =
                        widget.address?.contactPersonName ?? 'N/A';
                    _streetNumberController.text =
                        widget.address?.streetNumber ?? 'N/A';
                    _houseController.text = widget.address?.house ?? '';
                    _floorController.text = widget.address?.floor ?? '';
                  }
                } else if (userCubit.state.user != null &&
                    _contactPersonNameController.text.isEmpty) {
                  _contactPersonNameController.text =
                      '${userCubit.state.user?.firstName} ${userCubit.state.user?.lastName}';
                  _contactPersonNumberController.text =
                      userCubit.state.user?.phone ?? '';
                }

                return BlocConsumer<LocationCubit, LocationState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Column(
                      children: [
                        Expanded(
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.all(
                                  Dimensions.paddingSizeSmall),
                              child: Center(
                                child: SizedBox(
                                  width: Dimensions.webMaxWidth,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 140,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radiusSmall),
                                          border: Border.all(
                                              width: 2,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radiusSmall),
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              GoogleMap(
                                                initialCameraPosition:
                                                    CameraPosition(
                                                        target:
                                                            initialPosition ??
                                                                const LatLng(
                                                                    32, 24),
                                                        zoom: 17),
                                                onTap: (latLng) {
                                                  // Get.toNamed(
                                                  //   RouteHelper.getPickMapRoute('add-address', false),
                                                  //   arguments: PickMapScreen(
                                                  //     fromAddAddress: true, fromSignUp: false, googleMapController: locationController.mapController,
                                                  //     route: null, canRoute: false,
                                                  //   ),
                                                  // );
                                                },
                                                zoomControlsEnabled: false,
                                                compassEnabled: false,
                                                indoorViewEnabled: true,
                                                mapToolbarEnabled: false,
                                                onCameraIdle: () {
                                                  if (cameraPosition != null) {
                                                    locationCubit
                                                        .updatePosition(
                                                            cameraPosition!,
                                                            true);
                                                  }
                                                },
                                                onCameraMove: ((position) =>
                                                    cameraPosition = position),
                                                onMapCreated:
                                                    (GoogleMapController
                                                        controller) {
                                                  locationCubit
                                                      .setMapController(
                                                          controller);

                                                  if (widget.address == null) {
                                                    locationCubit
                                                        .getCurrentLocation(
                                                            true,
                                                            mapController:
                                                                controller);
                                                  }
                                                },
                                              ),
                                              state.loading
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator())
                                                  : const SizedBox.shrink(),
                                              Center(
                                                child: !state.loading
                                                    ? Image.asset(
                                                        Images.pickMarker,
                                                        height: 50,
                                                        width: 50)
                                                    : const CircularProgressIndicator(),
                                              ),
                                              Positioned(
                                                bottom: 10,
                                                right: 0,
                                                child: InkWell(
                                                  onTap: () =>
                                                      _checkPermission(() {
                                                    locationCubit
                                                        .getCurrentLocation(
                                                      true,
                                                      mapController:
                                                          state.mapController,
                                                    );
                                                  }),
                                                  child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    margin: const EdgeInsets
                                                            .only(
                                                        right: Dimensions
                                                            .paddingSizeLarge),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                .radiusSmall),
                                                        color: Colors.white),
                                                    child: Icon(
                                                        Icons.my_location,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        size: 20),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 10,
                                                right: 0,
                                                child: InkWell(
                                                  onTap: () {
                                                    // Get.toNamed(
                                                    //   RouteHelper
                                                    //       .getPickMapRoute(
                                                    //           'add-address',
                                                    //           false),
                                                    //   arguments: PickMapScreen(
                                                    //     fromAddAddress: true,
                                                    //     fromSignUp: false,
                                                    //     googleMapController:
                                                    //         locationController
                                                    //             .mapController,
                                                    //     route: null,
                                                    //     canRoute: false,
                                                    //   ),
                                                    // );
                                                  },
                                                  child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    margin: const EdgeInsets
                                                            .only(
                                                        right: Dimensions
                                                            .paddingSizeLarge),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                .radiusSmall),
                                                        color: Colors.white),
                                                    child: Icon(
                                                        Icons.fullscreen,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        size: 20),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }))
          : const NotLoggedInScreen(),
    );
  }

  void _checkPermission(Function onTap) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      // ShowSnackBar.showSnackBar(context,
      //     title: LocaleKeys.you_have_to_allow.tr());
    } else if (permission == LocationPermission.deniedForever) {
      //Get.dialog(PermissionDialog());
    } else {
      onTap();
    }
  }
}
