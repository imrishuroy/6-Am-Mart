import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '/utils/price_converter.dart';
import '/widgets/confirmation_dialog.dart';
import '/widgets/custom_button.dart';
import '/widgets/custom_image.dart';
import '/widgets/show_snakbar.dart';
import '/blocs/config/app_config_bloc.dart';
import '/blocs/order/order_cubit.dart';
import '/helpers/dimensions.dart';
import '/helpers/responsive_helper.dart';
import '/models/order_add_on.dart';
import '/models/order_details_model.dart';
import '/translations/locale_keys.g.dart';
import '/utils/date_converter.dart';
import '/utils/utils.dart';
import '/widgets/custom_appbar.dart';
import '/widgets/footer_view.dart';
import '/widgets/loading_indicator.dart';
import '/widgets/menu_drawer.dart';
import '/models/order_model.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'widgets/cart_widget.dart';
import 'widgets/details_widget.dart';
import 'widgets/order_item_widget.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderModel? orderModel;
  final int orderId;
  const OrderDetailsScreen(
      {Key? key, required this.orderModel, required this.orderId})
      : super(key: key);

  @override
  OrderDetailsScreenState createState() => OrderDetailsScreenState();
}

class OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late StreamSubscription _stream;

  void _loadData(BuildContext context, bool reload) async {
    final orderCubit = context.read<OrderCubit>();
    final configBloc = context.read<AppConfigBloc>();

    await orderCubit.trackOrder(
        widget.orderId.toString(), reload ? null : widget.orderModel, false);

    if (widget.orderModel == null) {
      // ignore: use_build_context_synchronously
      configBloc.add(LoadConfig());
    }

    orderCubit.getOrderDetails(widget.orderId.toString());
  }

  @override
  void initState() {
    super.initState();

    _stream = FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage on Details: ${message.data}');
      _loadData(context, true);
    });

    _loadData(context, false);
  }

  @override
  void dispose() {
    super.dispose();

    _stream.cancel();
  }
  // Module getModule(String moduleType) =>
  //     Module.fromJson(_data['module_config'][moduleType]);

  @override
  Widget build(BuildContext context) {
    final configBloc = context.read<AppConfigBloc>();
    return WillPopScope(
      onWillPop: () async {
        if (widget.orderModel == null) {
          return false;
          // return Get.offAllNamed(RouteHelper.getInitialRoute());
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
            title: LocaleKeys.order_details.tr(),
            onBackPressed: () {
              if (widget.orderModel == null) {
                //Get.offAllNamed(RouteHelper.getInitialRoute());
              } else {
                // Get.back();
              }
            }),
        endDrawer: const MenuDrawer(),
        body: BlocConsumer<OrderCubit, OrderState>(
          listener: (context, state) {},
          builder: (context, state) {
            double deliveryCharge = 0;
            double itemsPrice = 0;
            double discount = 0;
            double couponDiscount = 0;
            double tax = 0;
            double addOns = 0;
            OrderModel? order = state.trackModel;
            bool parcel = false;
            if (state.orderDetails != null) {
              parcel = order?.orderType == 'parcel';
              deliveryCharge = order?.deliveryCharge ?? 0.0;
              couponDiscount = order?.couponDiscountAmount ?? 0.0;
              discount = order?.storeDiscountAmount ?? 0.0;
              tax = order?.totalTaxAmount ?? 0.0;
              for (OrderDetailsModel? orderDetails in state.orderDetails) {
                for (OrderAddOn? addOn in orderDetails?.addOns ?? []) {
                  addOns =
                      addOns + ((addOn?.price ?? 0.0) * (addOn?.quantity ?? 0));
                }
                itemsPrice = itemsPrice +
                    ((orderDetails?.price ?? 0.0) *
                        (orderDetails?.quantity ?? 1));
              }
            }
            double subTotal = itemsPrice + addOns;
            double total = itemsPrice +
                addOns -
                discount +
                tax +
                deliveryCharge -
                couponDiscount;

            return state.orderDetails != null
                ? Column(
                    children: [
                      Expanded(
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: ResponsiveHelper.isDesktop(context)
                                ? EdgeInsets.zero
                                : const EdgeInsets.all(
                                    Dimensions.paddingSizeSmall),
                            child: FooterView(
                              child: SizedBox(
                                width: Dimensions.webMaxWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Text(
                                          '${parcel ? LocaleKeys.delivery_id.tr() : LocaleKeys.order_id.tr()}:',
                                          style: robotoRegular),
                                      const SizedBox(
                                          width:
                                              Dimensions.paddingSizeExtraSmall),
                                      Text('${order?.id}', style: robotoMedium),
                                      const SizedBox(
                                          width:
                                              Dimensions.paddingSizeExtraSmall),
                                      const Expanded(child: SizedBox()),
                                      const Icon(Icons.watch_later, size: 17),
                                      const SizedBox(
                                          width:
                                              Dimensions.paddingSizeExtraSmall),
                                      Text(
                                        order?.createdAt != null
                                            ? DateConverter
                                                .dateTimeStringToDateTime(
                                                order!.createdAt!,
                                                context: context,
                                              )
                                            : 'N/A',
                                        style: robotoRegular,
                                      ),
                                    ]),
                                    const SizedBox(
                                        height: Dimensions.paddingSizeSmall),

                                    order?.scheduled == 1
                                        ? Row(children: [
                                            Text(LocaleKeys.scheduled_at.tr(),
                                                style: robotoRegular),
                                            const SizedBox(
                                                width: Dimensions
                                                    .paddingSizeExtraSmall),
                                            Text(
                                                order?.scheduleAt != null
                                                    ? DateConverter
                                                        .dateTimeStringToDateTime(
                                                            order!.scheduleAt!,
                                                            context: context)
                                                    : 'N/A',
                                                style: robotoMedium),
                                          ])
                                        : const SizedBox.shrink(),
                                    SizedBox(
                                        height: order?.scheduled == 1
                                            ? Dimensions.paddingSizeSmall
                                            : 0),

                                    configBloc.state.configModel
                                                ?.orderDeliveryVerification ==
                                            true
                                        ? Row(children: [
                                            Text(
                                                LocaleKeys
                                                    .delivery_verification_code
                                                    .tr(),
                                                style: robotoRegular),
                                            const SizedBox(
                                                width: Dimensions
                                                    .paddingSizeExtraSmall),
                                            Text(order?.otp ?? 'N/A',
                                                style: robotoMedium),
                                          ])
                                        : const SizedBox.shrink(),
                                    SizedBox(
                                        height: configBloc.state.configModel
                                                    ?.orderDeliveryVerification ==
                                                true
                                            ? 10
                                            : 0),

                                    Row(children: [
                                      Text(order?.orderType ?? 'N/A',
                                          style: robotoMedium),
                                      const Expanded(child: SizedBox.shrink()),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal:
                                                Dimensions.paddingSizeSmall,
                                            vertical: Dimensions
                                                .paddingSizeExtraSmall),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radiusSmall),
                                        ),
                                        child: Text(
                                          order?.paymentMethod ==
                                                  'cash_on_delivery'
                                              ? LocaleKeys.cash_on_delivery.tr()
                                              : LocaleKeys.digital_payment.tr(),
                                          style: robotoRegular.copyWith(
                                              color:
                                                  Theme.of(context).cardColor,
                                              fontSize: Dimensions
                                                  .fontSizeExtraSmall),
                                        ),
                                      ),
                                    ]),
                                    const Divider(
                                        height: Dimensions.paddingSizeLarge),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical:
                                              Dimensions.paddingSizeExtraSmall),
                                      child: Row(children: [
                                        Text(
                                            '${parcel ? LocaleKeys.charge_pay_by.tr() : LocaleKeys.item.tr()}:',
                                            style: robotoRegular),
                                        const SizedBox(
                                            width: Dimensions
                                                .paddingSizeExtraSmall),
                                        Text(
                                          parcel
                                              ? order?.chargePayer ?? 'N/A'
                                              : state.orderDetails.length
                                                  .toString(),
                                          style: robotoMedium.copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        const Expanded(
                                            child: SizedBox.shrink()),
                                        Container(
                                            height: 7,
                                            width: 7,
                                            decoration: BoxDecoration(
                                              color: (order?.orderStatus ==
                                                          'failed' ||
                                                      order?.orderStatus ==
                                                          'refunded')
                                                  ? Colors.red
                                                  : Colors.green,
                                              shape: BoxShape.circle,
                                            )),
                                        const SizedBox(
                                            width: Dimensions
                                                .paddingSizeExtraSmall),
                                        Text(
                                          order?.orderStatus == 'delivered'
                                              ? '${'delivered_at'.tr} ${order?.delivered != null ? DateConverter.dateTimeStringToDateTime(order!.delivered!, context: context) : 'N/A'}'
                                              : order?.orderStatus ?? 'N/A',
                                          style: robotoRegular.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeSmall),
                                        ),
                                      ]),
                                    ),
                                    const Divider(
                                        height: Dimensions.paddingSizeLarge),
                                    const SizedBox(
                                        height: Dimensions.paddingSizeSmall),

                                    parcel
                                        ? CardWidget(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                DetailsWidget(
                                                    title: LocaleKeys
                                                        .sender_details
                                                        .tr(),
                                                    address:
                                                        order?.deliveryAddress),
                                                const SizedBox(
                                                    height: Dimensions
                                                        .paddingSizeLarge),
                                                DetailsWidget(
                                                  title: LocaleKeys
                                                      .receiver_details
                                                      .tr(),
                                                  address:
                                                      order?.receiverDetails,
                                                ),
                                              ],
                                            ),
                                          )
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount:
                                                state.orderDetails.length,
                                            padding: EdgeInsets.zero,
                                            itemBuilder: (context, index) {
                                              return OrderItemWidget(
                                                order: order,
                                                orderDetails:
                                                    state.orderDetails[index],
                                              );
                                            },
                                          ),
                                    SizedBox(
                                      height: parcel
                                          ? Dimensions.paddingSizeLarge
                                          : 0,
                                    ),

                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          (configBloc
                                                          .state
                                                          .configModel
                                                          ?.moduleConfig
                                                          ?.module
                                                          ?.orderAttachment ==
                                                      true &&
                                                  order?.orderAttachment !=
                                                      null &&
                                                  order?.orderAttachment != '')
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                      Text(
                                                          LocaleKeys
                                                              .prescription
                                                              .tr(),
                                                          style: robotoRegular),
                                                      const SizedBox(
                                                          height: Dimensions
                                                              .paddingSizeSmall),
                                                      InkWell(
                                                        onTap: () => openDialog(
                                                          context,
                                                          '${configBloc.state.configModel?.baseUrls?.orderAttachmentUrl}/${order?.orderAttachment}',
                                                        ),
                                                        child: Center(
                                                            child: ClipRRect(
                                                          borderRadius: BorderRadius
                                                              .circular(Dimensions
                                                                  .radiusSmall),
                                                          child: CustomImage(
                                                            image:
                                                                '${configBloc.state.configModel?.baseUrls?.orderAttachmentUrl}/${order?.orderAttachment}',
                                                            width: 100,
                                                            height: 100,
                                                          ),
                                                        )),
                                                      ),
                                                      const SizedBox(
                                                          height: Dimensions
                                                              .paddingSizeLarge),
                                                    ])
                                              : const SizedBox.shrink(),
                                          SizedBox(
                                              width: (configBloc
                                                              .state
                                                              .configModel
                                                              ?.moduleConfig
                                                              ?.module
                                                              ?.orderAttachment !=
                                                          null &&
                                                      order?.orderAttachment !=
                                                          '')
                                                  ? Dimensions.paddingSizeSmall
                                                  : 0),
                                          (order?.orderNote != null &&
                                                  order?.orderNote != '')
                                              ? Expanded(
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            LocaleKeys
                                                                .additional_note
                                                                .tr(),
                                                            style:
                                                                robotoRegular),
                                                        const SizedBox(
                                                            height: Dimensions
                                                                .paddingSizeSmall),
                                                        Container(
                                                          width: Dimensions
                                                              .webMaxWidth,
                                                          padding: const EdgeInsets
                                                                  .all(
                                                              Dimensions
                                                                  .paddingSizeSmall),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .radiusSmall),
                                                            border: Border.all(
                                                                width: 1,
                                                                color: Theme.of(
                                                                        context)
                                                                    .disabledColor),
                                                          ),
                                                          child: Text(
                                                            order?.orderNote ??
                                                                'N/A',
                                                            style: robotoRegular.copyWith(
                                                                fontSize: Dimensions
                                                                    .fontSizeSmall,
                                                                color: Theme.of(
                                                                        context)
                                                                    .disabledColor),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: Dimensions
                                                                .paddingSizeLarge),
                                                      ]),
                                                )
                                              : const SizedBox.shrink(),
                                        ]),

                                    CardWidget(
                                        showCard: parcel,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  parcel
                                                      ? LocaleKeys
                                                          .parcel_category
                                                          .tr()
                                                      : configBloc
                                                                  .state
                                                                  .configModel
                                                                  ?.moduleConfig
                                                                  ?.module
                                                                  ?.showRestaurantText ==
                                                              true
                                                          ? LocaleKeys
                                                              .restaurant_details
                                                              .tr()
                                                          : LocaleKeys
                                                              .store_details
                                                              .tr(),
                                                  style: robotoRegular),
                                              const SizedBox(
                                                  height: Dimensions
                                                      .paddingSizeExtraSmall),
                                              (parcel &&
                                                      order?.parcelCategory ==
                                                          null)
                                                  ? Text(
                                                      LocaleKeys
                                                          .no_parcel_category_data_found
                                                          .tr(),
                                                    )
                                                  : Row(children: [
                                                      ClipOval(
                                                        child: CustomImage(
                                                          image: parcel
                                                              ? '${configBloc.state.configModel?.baseUrls?.parcelCategoryImageUrl}/${order?.parcelCategory?.image}'
                                                              : '${configBloc.state.configModel?.baseUrls?.storeImageUrl}/${order?.store?.logo}',
                                                          height: 35,
                                                          width: 35,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          width: Dimensions
                                                              .paddingSizeSmall),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              parcel
                                                                  ? order?.parcelCategory
                                                                          ?.name ??
                                                                      'N/A'
                                                                  : order?.store
                                                                          ?.name ??
                                                                      'N/A',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: robotoRegular
                                                                  .copyWith(
                                                                      fontSize:
                                                                          Dimensions
                                                                              .fontSizeSmall),
                                                            ),
                                                            Text(
                                                              parcel
                                                                  ? order?.parcelCategory
                                                                          ?.description ??
                                                                      ''
                                                                  : order?.store
                                                                          ?.address ??
                                                                      '',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: robotoRegular.copyWith(
                                                                  fontSize:
                                                                      Dimensions
                                                                          .fontSizeSmall,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .disabledColor),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      (!parcel &&
                                                              order?.orderType ==
                                                                  'take_away' &&
                                                              (order
                                                                          ?.orderStatus ==
                                                                      'pending' ||
                                                                  order?.orderStatus ==
                                                                      'accepted' ||
                                                                  order?.orderStatus ==
                                                                      'confirmed' ||
                                                                  order?.orderStatus ==
                                                                      'processing' ||
                                                                  order?.orderStatus ==
                                                                      'handover' ||
                                                                  order?.orderStatus ==
                                                                      'picked_up'))
                                                          ? TextButton.icon(
                                                              onPressed:
                                                                  () async {
                                                                if (!parcel) {
                                                                  String url =
                                                                      'https://www.google.com/maps/dir/?api=1&destination=${order?.store?.latitude}'
                                                                      ',${order?.store?.longitude}&mode=d';
                                                                  if (await canLaunchUrlString(
                                                                      url)) {
                                                                    await launchUrlString(
                                                                        url);
                                                                  } else {
                                                                    ShowSnackBar.showSnackBar(
                                                                        context,
                                                                        title: LocaleKeys
                                                                            .unable_to_launch_google_map
                                                                            .tr());
                                                                  }
                                                                }
                                                              },
                                                              icon: const Icon(
                                                                  Icons
                                                                      .directions),
                                                              label: Text(
                                                                LocaleKeys
                                                                    .direction
                                                                    .tr(),
                                                              ),
                                                            )
                                                          : const SizedBox
                                                              .shrink()
                                                    ])
                                            ])),
                                    SizedBox(
                                        height: parcel
                                            ? 0
                                            : Dimensions.paddingSizeLarge),

                                    // Total
                                    parcel
                                        ? const SizedBox.shrink()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          LocaleKeys.item_price
                                                              .tr(),
                                                          style: robotoRegular),
                                                      Text(
                                                          PriceConverter
                                                              .convertPrice(
                                                                  itemsPrice,
                                                                  context:
                                                                      context),
                                                          style: robotoRegular),
                                                    ]),
                                                const SizedBox(height: 10),
                                                configBloc
                                                            .state
                                                            .configModel
                                                            ?.moduleConfig
                                                            ?.module
                                                            ?.addOn ==
                                                        true
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              LocaleKeys.addons
                                                                  .tr(),
                                                              style:
                                                                  robotoRegular),
                                                          Text(
                                                              '(+) ${PriceConverter.convertPrice(addOns, context: context)}',
                                                              style:
                                                                  robotoRegular),
                                                        ],
                                                      )
                                                    : const SizedBox.shrink(),
                                                configBloc
                                                            .state
                                                            .configModel
                                                            ?.moduleConfig
                                                            ?.module
                                                            ?.addOn ==
                                                        true
                                                    ? Divider(
                                                        thickness: 1,
                                                        color: Theme.of(context)
                                                            .hintColor
                                                            .withOpacity(0.5),
                                                      )
                                                    : const SizedBox.shrink(),
                                                configBloc
                                                            .state
                                                            .configModel
                                                            ?.moduleConfig
                                                            ?.module
                                                            ?.addOn ==
                                                        true
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              LocaleKeys
                                                                  .subtotal
                                                                  .tr(),
                                                              style:
                                                                  robotoMedium),
                                                          Text(
                                                              PriceConverter
                                                                  .convertPrice(
                                                                      subTotal,
                                                                      context:
                                                                          context),
                                                              style:
                                                                  robotoMedium),
                                                        ],
                                                      )
                                                    : SizedBox(),
                                                SizedBox(
                                                    height: configBloc
                                                                .state
                                                                .configModel
                                                                ?.moduleConfig
                                                                ?.module
                                                                ?.addOn ==
                                                            true
                                                        ? 10
                                                        : 0),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          LocaleKeys.discount
                                                              .tr(),
                                                          style: robotoRegular),
                                                      Text(
                                                          '(-) ${PriceConverter.convertPrice(discount, context: context)}',
                                                          style: robotoRegular),
                                                    ]),
                                                const SizedBox(height: 10),
                                                couponDiscount > 0
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                            Text(
                                                                LocaleKeys
                                                                    .coupon_discount
                                                                    .tr(),
                                                                style:
                                                                    robotoRegular),
                                                            Text(
                                                              '(-) ${PriceConverter.convertPrice(couponDiscount, context: context)}',
                                                              style:
                                                                  robotoRegular,
                                                            ),
                                                          ])
                                                    : const SizedBox.shrink(),
                                                SizedBox(
                                                    height: couponDiscount > 0
                                                        ? 10
                                                        : 0),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          LocaleKeys.vat_tax
                                                              .tr(),
                                                          style: robotoRegular),
                                                      Text(
                                                          '(+) ${PriceConverter.convertPrice(tax, context: context)}',
                                                          style: robotoRegular),
                                                    ]),
                                                const SizedBox(height: 10),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          LocaleKeys
                                                              .delivery_fee
                                                              .tr(),
                                                          style: robotoRegular),
                                                      deliveryCharge > 0
                                                          ? Text(
                                                              '(+) ${PriceConverter.convertPrice(deliveryCharge, context: context)}',
                                                              style:
                                                                  robotoRegular,
                                                            )
                                                          : Text(
                                                              LocaleKeys.free
                                                                  .tr(),
                                                              style: robotoRegular.copyWith(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor)),
                                                    ]),
                                              ]),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical:
                                              Dimensions.paddingSizeSmall),
                                      child: Divider(
                                          thickness: 1,
                                          color: Theme.of(context)
                                              .hintColor
                                              .withOpacity(0.5)),
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(LocaleKeys.total_amount.tr(),
                                            style: robotoMedium.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeLarge,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )),
                                        Text(
                                          PriceConverter.convertPrice(total,
                                              context: context),
                                          style: robotoMedium.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeLarge,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                        height:
                                            ResponsiveHelper.isDesktop(context)
                                                ? Dimensions.paddingSizeLarge
                                                : 0),
                                    ResponsiveHelper.isDesktop(context)
                                        ? _bottomView(
                                            context.read<OrderCubit>(),
                                            order,
                                            parcel)
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      ResponsiveHelper.isDesktop(context)
                          ? const SizedBox.shrink()
                          : _bottomView(
                              context.read<OrderCubit>(), order, parcel),
                    ],
                  )
                : const LoadingIndicator();
          },
        ),
      ),
    );
  }

  void openDialog(BuildContext context, String imageUrl) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radiusLarge)),
            child: Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                child: PhotoView(
                  tightMode: true,
                  imageProvider: NetworkImage(imageUrl),
                  heroAttributes: PhotoViewHeroAttributes(tag: imageUrl),
                ),
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    splashRadius: 5,
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.cancel, color: Colors.red),
                  )),
            ]),
          );
        },
      );

  Widget _bottomView(OrderCubit orderCubit, OrderModel? order, bool parcel) {
    return Column(children: [
      !orderCubit.state.showCancelled
          ? Center(
              child: SizedBox(
                width: Dimensions.webMaxWidth,
                child: Row(children: [
                  (order?.orderStatus == 'pending' ||
                          order?.orderStatus == 'accepted' ||
                          order?.orderStatus == 'confirmed' ||
                          order?.orderStatus == 'processing' ||
                          order?.orderStatus == 'handover' ||
                          order?.orderStatus == 'picked_up')
                      ? Expanded(
                          child: CustomButton(
                            buttonText: parcel
                                ? LocaleKeys.track_delivery.tr()
                                : LocaleKeys.track_order.tr(),
                            margin: ResponsiveHelper.isDesktop(context)
                                ? null
                                : const EdgeInsets.all(
                                    Dimensions.paddingSizeSmall),
                            onPressed: () {
                              // Get.toNamed(
                              //     RouteHelper.getOrderTrackingRoute(order.id));
                            },
                          ),
                        )
                      : const SizedBox.shrink(),
                  order?.orderStatus == 'pending'
                      ? Expanded(
                          child: Padding(
                          padding: ResponsiveHelper.isDesktop(context)
                              ? EdgeInsets.zero
                              : const EdgeInsets.all(
                                  Dimensions.paddingSizeSmall),
                          child: TextButton(
                            style: TextButton.styleFrom(
                                minimumSize: const Size(1, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radiusSmall),
                                  side: BorderSide(
                                      width: 2,
                                      color: Theme.of(context).disabledColor),
                                )),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => ConfirmationDialog(
                                        icon: Images.warning,
                                        description: LocaleKeys
                                            .are_you_sure_to_cancel
                                            .tr(),
                                        onYesPressed: () {
                                          if (order?.id != null) {
                                            orderCubit.cancelOrder(order!.id!);
                                          }
                                        },
                                      ));
                            },
                            child: Text(
                                parcel
                                    ? LocaleKeys.cancel_delivery.tr()
                                    : LocaleKeys.cancel_order.tr(),
                                style: robotoBold.copyWith(
                                  color: Theme.of(context).disabledColor,
                                  fontSize: Dimensions.fontSizeLarge,
                                )),
                          ),
                        ))
                      : const SizedBox.shrink(),
                ]),
              ),
            )
          : Center(
              child: Container(
                width: Dimensions.webMaxWidth,
                height: 50,
                margin: ResponsiveHelper.isDesktop(context)
                    ? null
                    : const EdgeInsets.all(Dimensions.paddingSizeSmall),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 2, color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                ),
                child: Text(LocaleKeys.order_cancelled.tr(),
                    style: robotoMedium.copyWith(
                        color: Theme.of(context).primaryColor)),
              ),
            ),
      (order?.orderStatus == 'delivered' &&
              (parcel
                  ? order?.deliveryMan != null
                  : orderCubit.state.orderDetails[0]?.itemCampaignId == null))
          ? Center(
              child: Container(
                width: Dimensions.webMaxWidth,
                padding: ResponsiveHelper.isDesktop(context)
                    ? null
                    : const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: CustomButton(
                  buttonText: LocaleKeys.review.tr(),
                  onPressed: () {
                    List<OrderDetailsModel> orderDetailsList = [];
                    List<int> orderDetailsIdList = [];
                    for (var orderDetail in orderCubit.state.orderDetails) {
                      if (!orderDetailsIdList
                          .contains(orderDetail?.itemDetails?.id)) {
                        if (orderDetail != null &&
                            orderDetail.itemDetails?.id != null) {
                          orderDetailsList.add(orderDetail);
                          orderDetailsIdList.add(orderDetail.itemDetails!.id);
                        }
                      }
                    }

                    // TODO: implement this
                    // Get.toNamed(RouteHelper.getReviewRoute(),
                    //     arguments: RateReviewScreen(
                    //       orderDetailsList: orderDetailsList,
                    //       deliveryMan: order.deliveryMan,
                    //       orderID: order.id,
                    //     ));
                  },
                ),
              ),
            )
          : const SizedBox.shrink(),
      (order?.orderStatus == 'failed' &&
              context.read<AppConfigBloc>().state.configModel?.cashOnDelivery ==
                  true)
          ? Center(
              child: Container(
                width: Dimensions.webMaxWidth,
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: CustomButton(
                  buttonText: LocaleKeys.switch_to_cash_on_delivery.tr(),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => ConfirmationDialog(
                        icon: Images.warning,
                        description: LocaleKeys.are_you_sure_to_switch.tr(),
                        onYesPressed: () {
                          if (order?.id != null) {
                            orderCubit
                                .switchToCOD(order!.id.toString())
                                .then((isSuccess) {
                              Navigator.of(context).pop();
                              if (isSuccess) {
                                Navigator.of(context).pop();
                              }
                            });
                          }
                        },
                        onNoPressed: () {},
                      ),
                    );

                    // Get.dialog(ConfirmationDialog(
                    //     icon: Images.warning,
                    //     description: 'are_you_sure_to_switch'.tr,
                    //     onYesPressed: () {
                    //       orderController
                    //           .switchToCOD(order.id.toString())
                    //           .then((isSuccess) {
                    //         Get.back();
                    //         if (isSuccess) {
                    //           Get.back();
                    //         }
                    //       });
                    //     }));
                  },
                ),
              ),
            )
          : const SizedBox.shrink()
    ]);
  }
}
