import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:six_am_mart/screens/address/add_address_screen.dart';
import '/blocs/auth/auth_bloc.dart';
import '/blocs/location/location_cubit.dart';
import '/helpers/dimensions.dart';
import '/helpers/responsive_helper.dart';
import '/translations/locale_keys.g.dart';
import '/utils/utils.dart';
import '/widgets/confirmation_dialog.dart';
import '/widgets/custom_appbar.dart';
import '/widgets/custom_loader.dart';
import '/widgets/footer_view.dart';
import '/widgets/menu_drawer.dart';
import '/widgets/no_data_screen.dart';
import '/widgets/not_login_screen.dart';
import '/widgets/show_snakbar.dart';

import 'widgets/address_widget.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const AddressScreen(),
    );
  }

  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    _isLoggedIn = context.read<AuthBloc>().state.isLoggedIn();

    if (_isLoggedIn) {
      context.read<LocationCubit>().getAddressList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationCubit = context.read<LocationCubit>();
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.my_address.tr()),
      endDrawer: const MenuDrawer(),
      floatingActionButton: ResponsiveHelper.isDesktop(context)
          ? null
          : FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () => Navigator.of(context).pushNamed(
                  AddAddressScreen.routeName,
                  arguments: const AddAddressArgs(fromCheckout: true)),
              // Get.toNamed(RouteHelper.getAddAddressRoute(false)),
              child: Icon(Icons.add, color: Theme.of(context).cardColor),
            ),
      floatingActionButtonLocation: ResponsiveHelper.isDesktop(context)
          ? FloatingActionButtonLocation.centerFloat
          : null,
      body: _isLoggedIn
          ? BlocConsumer<LocationCubit, LocationState>(
              listener: (context, state) {},
              builder: (context, state) {
                return RefreshIndicator(
                  onRefresh: () async {
                    await locationCubit.getAddressList();
                  },
                  child: Scrollbar(
                      child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Center(
                        child: FooterView(
                      child: SizedBox(
                        width: Dimensions.webMaxWidth,
                        child: Column(
                          children: [
                            ResponsiveHelper.isDesktop(context)
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions.paddingSizeSmall,
                                        vertical: Dimensions.paddingSizeSmall),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            LocaleKeys.address.tr(),
                                            style: robotoMedium.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeLarge,
                                            ),
                                          ),
                                          TextButton.icon(
                                            icon: const Icon(Icons.add),
                                            label: Text(
                                              LocaleKeys.add_address.tr(),
                                            ),
                                            onPressed: () {
                                              // Get.toNamed(
                                              //     RouteHelper.getAddAddressRoute(
                                              //         false)),
                                            },
                                          ),
                                        ]),
                                  )
                                : const SizedBox.shrink(),
                            locationCubit.state.addressList.isNotEmpty
                                ? ListView.builder(
                                    padding: const EdgeInsets.all(
                                        Dimensions.paddingSizeSmall),
                                    itemCount:
                                        locationCubit.state.addressList.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Dismissible(
                                        key: UniqueKey(),
                                        onDismissed: (dir) {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  const CustomLoader(),
                                              barrierDismissible: false);
                                          if (state.addressList[index].id !=
                                              null) {
                                            locationCubit
                                                .deleteUserAddressByID(
                                                    state
                                                        .addressList[index].id!,
                                                    index)
                                                .then((response) {
                                              Navigator.pop(context);
                                              ShowSnackBar.showSnackBar(context,
                                                  title: response.message,
                                                  backgroundColor:
                                                      !response.isSuccess
                                                          ? Colors.red
                                                          : null);
                                            });
                                          }
                                        },
                                        child: AddressWidget(
                                          address: state.addressList[index],
                                          fromAddress: true,
                                          onTap: () {
                                            // Get.toNamed(RouteHelper.getMapRoute(
                                            //   locationController
                                            //       .addressList[index],
                                            //   'address',
                                            // ));
                                          },
                                          onEditPressed: () {
                                            // Get.toNamed(RouteHelper.getEditAddressRoute(locationController.addressList[index]));
                                          },
                                          onRemovePressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return ConfirmationDialog(
                                                    icon: Images.warning,
                                                    description: LocaleKeys
                                                        .are_you_sure_want_to_delete_address
                                                        .tr(),
                                                    onYesPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      showDialog(
                                                          barrierDismissible:
                                                              false,
                                                          context: context,
                                                          builder: (context) {
                                                            return const CustomLoader();
                                                          });
                                                      if (state
                                                              .addressList[
                                                                  index]
                                                              .id !=
                                                          null) {
                                                        locationCubit
                                                            .deleteUserAddressByID(
                                                                state
                                                                    .addressList[
                                                                        index]
                                                                    .id!,
                                                                index)
                                                            .then((response) {
                                                          Navigator.of(context)
                                                              .pop();
                                                          ShowSnackBar
                                                              .showSnackBar(
                                                            context,
                                                            title: response
                                                                .message,
                                                            backgroundColor:
                                                                !response
                                                                        .isSuccess
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .green,
                                                          );
                                                        });
                                                      }
                                                    });
                                              },
                                            );
                                          },
                                        ),
                                      );
                                    })
                                : NoDataScreen(
                                    text:
                                        LocaleKeys.no_saved_address_found.tr())
                          ],
                        ),
                      ),
                    )),
                  )),
                );
              },
            )
          : const NotLoggedInScreen(),
    );
  }
}
