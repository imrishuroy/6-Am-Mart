import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/config/app_config_bloc.dart';
import '/blocs/order/order_cubit.dart';
import '/helpers/dimensions.dart';
import '/helpers/responsive_helper.dart';
import '/models/paginated_order_model.dart';
import '/translations/locale_keys.g.dart';
import '/utils/date_converter.dart';
import '/utils/utils.dart';
import '/widgets/custom_image.dart';
import '/widgets/footer_view.dart';
import '/widgets/no_data_screen.dart';
import '/widgets/paginated_list_view.dart';

import 'order_shimmer.dart';

class OrderView extends StatefulWidget {
  final bool isRunning;
  const OrderView({Key? key, required this.isRunning}) : super(key: key);

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderCubit = context.read<OrderCubit>();
    final configBloc = context.read<AppConfigBloc>();
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          //if(state.status)
          print('Order view status --- ${state.toString()}');
          if (state.status == OrderStatus.succuss) {
            print('Thins rns -----');
            print('Order view status  2--- ${state.toString()}');
            print('Running model ${state.runningOrderModel}');
            print('History order model  ${state.historyOrderModel}');
            PaginatedOrderModel? paginatedOrderModel;

            if (state.runningOrderModel != null &&
                state.historyOrderModel != null) {
              paginatedOrderModel = widget.isRunning
                  ? state.runningOrderModel
                  : state.historyOrderModel;
            }

            //paginatedOrderModel = state.runningOrderModel;

            print('Paginaed order model $paginatedOrderModel');

            print('Orders -- ${paginatedOrderModel?.orders}');
            return paginatedOrderModel != null
                ? paginatedOrderModel.orders.isNotEmpty
                    ? RefreshIndicator(
                        onRefresh: () async {
                          if (widget.isRunning) {
                            await orderCubit.getRunningOrders(1);
                          } else {
                            await orderCubit.getHistoryOrders(1);
                          }
                        },
                        child: Scrollbar(
                            child: SingleChildScrollView(
                          controller: scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: FooterView(
                            child: SizedBox(
                              width: Dimensions.webMaxWidth,
                              child: PaginatedListView(
                                scrollController: scrollController,
                                onPaginate: (int offset) {
                                  if (widget.isRunning) {
                                    context
                                        .read<OrderCubit>()
                                        .getRunningOrders(offset);
                                  } else {
                                    context
                                        .read<OrderCubit>()
                                        .getHistoryOrders(offset);
                                  }
                                },
                                totalSize: paginatedOrderModel.totalSize,
                                offset: paginatedOrderModel.offset,
                                itemView: ListView.builder(
                                  padding: const EdgeInsets.all(
                                      Dimensions.paddingSizeSmall),
                                  itemCount: paginatedOrderModel.orders.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    bool isParcel = paginatedOrderModel
                                            ?.orders[index]?.orderType ==
                                        'parcel';

                                    return InkWell(
                                      onTap: () {
                                        // TODO: implement navigation
                                        // Get.toNamed(
                                        //   RouteHelper.getOrderDetailsRoute(paginatedOrderModel.orders[index].id),
                                        //   arguments: OrderDetailsScreen(
                                        //     orderId: paginatedOrderModel.orders[index].id,
                                        //     orderModel: paginatedOrderModel.orders[index],
                                        //   ),
                                        // );
                                      },
                                      child: Container(
                                        padding:
                                            ResponsiveHelper.isDesktop(context)
                                                ? const EdgeInsets.all(
                                                    Dimensions.paddingSizeSmall)
                                                : null,
                                        margin:
                                            ResponsiveHelper.isDesktop(context)
                                                ? const EdgeInsets.only(
                                                    bottom: Dimensions
                                                        .paddingSizeSmall)
                                                : null,
                                        decoration: ResponsiveHelper.isDesktop(
                                                context)
                                            ? BoxDecoration(
                                                color:
                                                    Theme.of(context).cardColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radiusSmall),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                          Colors.grey.shade300,
                                                      blurRadius: 5,
                                                      spreadRadius: 1)
                                                ],
                                              )
                                            : null,
                                        child: Column(children: [
                                          Row(children: [
                                            Stack(children: [
                                              Container(
                                                height: 60,
                                                width: 60,
                                                alignment: Alignment.center,
                                                decoration: isParcel
                                                    ? BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                .radiusSmall),
                                                        color: Theme.of(context)
                                                            .primaryColor
                                                            .withOpacity(0.2),
                                                      )
                                                    : null,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions
                                                              .radiusSmall),
                                                  child: CustomImage(
                                                    image: isParcel
                                                        ? '${configBloc.state.configModel?.baseUrls?.parcelCategoryImageUrl}'
                                                            '/${paginatedOrderModel?.orders[index]?.parcelCategory != null ? paginatedOrderModel?.orders[index]?.parcelCategory?.image : ''}'
                                                        : '${configBloc.state.configModel?.baseUrls?.storeImageUrl}/${paginatedOrderModel?.orders[index]?.store?.logo}',
                                                    height: isParcel ? 35 : 60,
                                                    width: isParcel ? 35 : 60,
                                                    fit: isParcel
                                                        ? BoxFit.none
                                                        : BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              isParcel
                                                  ? Positioned(
                                                      left: 0,
                                                      top: 10,
                                                      child: Container(
                                                        padding: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: Dimensions
                                                                .paddingSizeExtraLarge),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius: const BorderRadius
                                                                  .horizontal(
                                                              right: Radius
                                                                  .circular(
                                                                      Dimensions
                                                                          .radiusSmall)),
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                        child: Text(
                                                            LocaleKeys.parcel
                                                                .tr(),
                                                            style: robotoMedium
                                                                .copyWith(
                                                              fontSize: Dimensions
                                                                  .fontSizeExtraSmall,
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                      ))
                                                  : const SizedBox.shrink(),
                                            ]),
                                            const SizedBox(
                                                width: Dimensions
                                                    .paddingSizeSmall),
                                            Expanded(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(children: [
                                                      Text(
                                                        '${isParcel ? 'delivery_id'.tr : 'order_id'.tr}:',
                                                        style: robotoRegular.copyWith(
                                                            fontSize: Dimensions
                                                                .fontSizeSmall),
                                                      ),
                                                      const SizedBox(
                                                          width: Dimensions
                                                              .paddingSizeExtraSmall),
                                                      Text(
                                                          '#${paginatedOrderModel?.orders[index]?.id}',
                                                          style: robotoMedium
                                                              .copyWith(
                                                                  fontSize:
                                                                      Dimensions
                                                                          .fontSizeSmall)),
                                                    ]),
                                                    const SizedBox(
                                                        height: Dimensions
                                                            .paddingSizeSmall),
                                                    Text(
                                                      paginatedOrderModel
                                                                  ?.orders[
                                                                      index]
                                                                  ?.createdAt !=
                                                              null
                                                          ? DateConverter
                                                              .dateTimeStringToDateTime(
                                                                  paginatedOrderModel!
                                                                      .orders[
                                                                          index]!
                                                                      .createdAt!,
                                                                  context:
                                                                      context)
                                                          : 'N/A',
                                                      style: robotoRegular.copyWith(
                                                          color: Theme.of(
                                                                  context)
                                                              .disabledColor,
                                                          fontSize: Dimensions
                                                              .fontSizeSmall),
                                                    ),
                                                  ]),
                                            ),
                                            const SizedBox(
                                                width: Dimensions
                                                    .paddingSizeSmall),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: Dimensions
                                                            .paddingSizeSmall,
                                                        vertical: Dimensions
                                                            .paddingSizeExtraSmall),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimensions
                                                                  .radiusSmall),
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                    child: Text(
                                                        paginatedOrderModel
                                                                ?.orders[index]
                                                                ?.orderStatus ??
                                                            '',
                                                        style: robotoMedium
                                                            .copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeExtraSmall,
                                                          color:
                                                              Theme.of(context)
                                                                  .cardColor,
                                                        )),
                                                  ),
                                                  const SizedBox(
                                                      height: Dimensions
                                                          .paddingSizeSmall),
                                                  widget.isRunning
                                                      ? InkWell(
                                                          onTap: () {},

                                                          //   Get.toNamed(RouteHelper.getOrderTrackingRoute(paginatedOrderModel.orders[index].id)),
                                                          child: Container(
                                                            padding: const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    Dimensions
                                                                        .paddingSizeSmall,
                                                                vertical: Dimensions
                                                                    .paddingSizeExtraSmall),
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
                                                                      .primaryColor),
                                                            ),
                                                            child: Row(
                                                                children: [
                                                                  Image.asset(
                                                                      Images
                                                                          .tracking,
                                                                      height:
                                                                          15,
                                                                      width: 15,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor),
                                                                  const SizedBox(
                                                                      width: Dimensions
                                                                          .paddingSizeExtraSmall),
                                                                  Text(
                                                                      isParcel
                                                                          ? LocaleKeys
                                                                              .track_delivery
                                                                              .tr()
                                                                          : LocaleKeys
                                                                              .track_order
                                                                              .tr(),
                                                                      style: robotoMedium
                                                                          .copyWith(
                                                                        fontSize:
                                                                            Dimensions.fontSizeExtraSmall,
                                                                        color: Theme.of(context)
                                                                            .primaryColor,
                                                                      )),
                                                                ]),
                                                          ),
                                                        )
                                                      : Text(
                                                          '${paginatedOrderModel?.orders[index]?.detailsCount} ${(paginatedOrderModel?.orders[index]?.detailsCount ?? 0) > 1 ? 'items'.tr : 'item'.tr}',
                                                          style: robotoRegular
                                                              .copyWith(
                                                                  fontSize:
                                                                      Dimensions
                                                                          .fontSizeExtraSmall),
                                                        ),
                                                ]),
                                          ]),
                                          (index ==
                                                      ((paginatedOrderModel
                                                                  ?.orders
                                                                  .length ??
                                                              0) -
                                                          1) ||
                                                  ResponsiveHelper.isDesktop(
                                                      context))
                                              ? const SizedBox.shrink()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 70),
                                                  child: Divider(
                                                    color: Theme.of(context)
                                                        .disabledColor,
                                                    height: Dimensions
                                                        .paddingSizeLarge,
                                                  ),
                                                ),
                                        ]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        )))
                    : NoDataScreen(
                        text: LocaleKeys.no_order_found.tr(), showFooter: true)
                : OrderShimmer(runningOrderModel: state.runningOrderModel);
          }

          return OrderShimmer(runningOrderModel: state.runningOrderModel);
        },
      ),
    );
  }
}
