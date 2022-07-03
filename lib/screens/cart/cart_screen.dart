import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/cart/cart_cubit.dart';
import '/blocs/config/app_config_bloc.dart';
import '/helpers/dimensions.dart';
import '/helpers/responsive_helper.dart';
import '/models/add_ons.dart';
import '/translations/locale_keys.g.dart';
import '/utils/date_converter.dart';
import '/utils/price_converter.dart';
import '/utils/utils.dart';
import '/widgets/custom_appbar.dart';
import '/widgets/custom_button.dart';
import '/widgets/footer_view.dart';
import '/widgets/menu_drawer.dart';
import '/widgets/no_data_screen.dart';

import 'widgets/cart_item_widget.dart';
import 'widgets/web_constrained_box.dart';

class CartScreen extends StatefulWidget {
  final bool fromNav;
  const CartScreen({Key? key, required this.fromNav}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final configBloc = context.read<AppConfigBloc>();
    return Scaffold(
        appBar: CustomAppBar(
            title: LocaleKeys.my_cart.tr(),
            backButton:
                (ResponsiveHelper.isDesktop(context) || !widget.fromNav)),
        endDrawer: const MenuDrawer(),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            List<List<AddOns>> _addOnsList = [];
            List<bool> _availableList = [];
            double _itemPrice = 0;
            double _addOns = 0;

            state.cartList.forEach((cartModel) {
              List<AddOns> _addOnList = [];
              cartModel?.addOnIds.forEach((addOnId) {
                for (AddOns? addOns in cartModel.item?.addOns ?? []) {
                  if (addOns?.id == addOnId?.id) {
                    if (addOns != null) {
                      _addOnList.add(addOns);
                    }

                    break;
                  }
                }
              });
              _addOnsList.add(_addOnList);

              _availableList.add(DateConverter.isAvailable(
                  context,
                  cartModel?.item?.availableTimeStarts ?? '',
                  cartModel?.item?.availableTimeEnds ?? ''));

              for (int index = 0; index < _addOnList.length; index++) {
                _addOns = _addOns +
                    (_addOnList[index].price ??
                        0 * (cartModel?.addOnIds[index]?.quantity ?? 1.0));
              }
              _itemPrice = _itemPrice +
                  ((cartModel?.price ?? 1.0) * (cartModel?.quantity ?? 1));
            });
            double subTotal = _itemPrice + _addOns;

            return state.cartList.isNotEmpty
                ? Column(
                    children: [
                      Expanded(
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            padding: ResponsiveHelper.isDesktop(context)
                                ? const EdgeInsets.only(
                                    top: Dimensions.paddingSizeSmall,
                                  )
                                : const EdgeInsets.all(
                                    Dimensions.paddingSizeSmall),
                            physics: const BouncingScrollPhysics(),
                            child: FooterView(
                              child: SizedBox(
                                width: Dimensions.webMaxWidth,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Product
                                      WebConstrainedBox(
                                        dataLength: state.cartList.length,
                                        minLength: 5,
                                        minHeight: 0.6,
                                        child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: state.cartList.length,
                                          itemBuilder: (context, index) {
                                            return state.cartList[index] != null
                                                ? CartItemWidget(
                                                    cart:
                                                        state.cartList[index]!,
                                                    cartIndex: index,
                                                    addOns: _addOnsList[index],
                                                    isAvailable:
                                                        _availableList[index])
                                                : const SizedBox.shrink();
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeSmall),

                                      // Total
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(LocaleKeys.item_price.tr(),
                                                style: robotoRegular),
                                            Text(
                                                PriceConverter.convertPrice(
                                                    _itemPrice,
                                                    context: context),
                                                style: robotoRegular),
                                          ]),
                                      SizedBox(
                                          height: configBloc
                                                      .state
                                                      .configModel
                                                      ?.moduleConfig
                                                      ?.module
                                                      ?.addOn ==
                                                  true
                                              ? 10.0
                                              : 0),

                                      configBloc.state.configModel?.moduleConfig
                                                  ?.module?.addOn ==
                                              true
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(LocaleKeys.addons.tr(),
                                                    style: robotoRegular),
                                                Text(
                                                    '(+) ${PriceConverter.convertPrice(_addOns, context: context)}',
                                                    style: robotoRegular),
                                              ],
                                            )
                                          : const SizedBox.shrink(),
                                      configBloc.state.configModel?.moduleConfig
                                                  ?.module?.addOn ==
                                              true
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical:
                                                    Dimensions.paddingSizeSmall,
                                              ),
                                              child: Divider(
                                                  thickness: 1,
                                                  color: Theme.of(context)
                                                      .hintColor
                                                      .withOpacity(0.5)),
                                            )
                                          : const SizedBox.shrink(),
                                      configBloc.state.configModel?.moduleConfig
                                                  ?.module?.addOn ==
                                              true
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(LocaleKeys.subtotal.tr(),
                                                    style: robotoMedium),
                                                Text(
                                                    PriceConverter.convertPrice(
                                                        subTotal,
                                                        context: context),
                                                    style: robotoMedium),
                                              ],
                                            )
                                          : const SizedBox.shrink(),

                                      ResponsiveHelper.isDesktop(context)
                                          ? CheckoutButton(
                                              //cartController: cartController,
                                              availableList: _availableList)
                                          : const SizedBox.shrink(),
                                    ]),
                              ),
                            ),
                          ),
                        ),
                      ),
                      ResponsiveHelper.isDesktop(context)
                          ? const SizedBox.shrink()
                          : CheckoutButton(
                              //   cartController: cartController,
                              availableList: _availableList,
                            ),
                    ],
                  )
                : const NoDataScreen(isCart: true, text: '', showFooter: true);
          },
        ));
  }
}

class CheckoutButton extends StatelessWidget {
  //final CartController cartController;
  final List<bool> availableList;
  const CheckoutButton({Key? key, required this.availableList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.webMaxWidth,
      padding: ResponsiveHelper.isDesktop(context)
          ? const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge)
          : const EdgeInsets.all(Dimensions.paddingSizeSmall),
      child: CustomButton(
          buttonText: LocaleKeys.proceed_to_checkout.tr(),
          onPressed: () {
            // if (Get.find<SplashController>().module == null) {
            //   showCustomSnackBar('choose_a_module_first'.tr);
            // } else if (!cartController.cartList.first.item.scheduleOrder &&
            //     availableList.contains(false)) {
            //   showCustomSnackBar('one_or_more_product_unavailable'.tr);
            // } else {
            //   Get.find<CouponController>().removeCouponData(false);
            //   Get.toNamed(RouteHelper.getCheckoutRoute('cart'));
            // }
          }),
    );
  }
}
