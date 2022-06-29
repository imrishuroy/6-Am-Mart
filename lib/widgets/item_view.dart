import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:six_am_mart/blocs/config/app_config_bloc.dart';
import 'package:six_am_mart/translations/locale_keys.g.dart';
import '/helpers/dimensions.dart';
import '/helpers/responsive_helper.dart';
import '/models/item.dart';
import '/models/store.dart';
import 'item_shimmer.dart';
import 'item_widget.dart';
import 'no_data_screen.dart';
import 'store_widget.dart';

class ItemsView extends StatelessWidget {
  final List<Item?>? items;
  final List<Store?>? stores;
  final bool isStore;
  final EdgeInsetsGeometry padding;
  final bool isScrollable;
  final int shimmerLength;
  final String? noDataText;
  final bool isCampaign;
  final bool inStorePage;
  final String? type;
  final bool isFeatured;
  final bool showTheme1Store;
  final Function(String type)? onVegFilterTap;

  const ItemsView({
    Key? key,
    required this.stores,
    required this.items,
    required this.isStore,
    this.isScrollable = false,
    this.shimmerLength = 20,
    this.padding = const EdgeInsets.all(Dimensions.paddingSizeSmall),
    required this.noDataText,
    this.isCampaign = false,
    this.inStorePage = false,
    this.type,
    this.onVegFilterTap,
    this.isFeatured = false,
    this.showTheme1Store = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final configBloc = context.read<AppConfigBloc>();
    String text = LocaleKeys.no_store_available.tr();

    bool showRestaurant =
        configBloc.state.config?.moduleConfig?.module?.showRestaurantText ??
            false;
    if (showRestaurant) {
      text = LocaleKeys.no_restaurant_available.tr();
    }

    bool _isNull = true;
    int _length = 0;
    if (isStore) {
      _isNull = stores == null;
      if (!_isNull) {
        _length = stores?.length ?? 0;
      }
    } else {
      _isNull = items == null;
      if (!_isNull) {
        _length = items?.length ?? 0;
      }
    }

    return Column(children: [
      type != null
          ? const SizedBox.shrink()
          //VegFilterWidget(type: type, onSelected: onVegFilterTap)
          : const SizedBox(),
      !_isNull
          ? _length > 0
              ? GridView.builder(
                  key: UniqueKey(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: Dimensions.paddingSizeSmall,
                    mainAxisSpacing: ResponsiveHelper.isDesktop(context)
                        ? Dimensions.paddingSizeLarge
                        : 0.01,
                    childAspectRatio: ResponsiveHelper.isDesktop(context)
                        ? 4
                        : showTheme1Store
                            ? 1.9
                            : 4,
                    crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 2,
                  ),
                  physics: isScrollable
                      ? const BouncingScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  shrinkWrap: isScrollable ? false : true,
                  itemCount: _length,
                  padding: padding,
                  itemBuilder: (context, index) {
                    return showTheme1Store
                        ? StoreWidget(
                            store: stores?[index],
                            index: index,
                            inStore: inStorePage)
                        : ItemWidget(
                            isStore: isStore,
                            item: isStore ? null : items?[index],
                            store: isStore
                                ? stores != null
                                    ? stores![index]
                                    : null
                                : null,
                            index: index,
                            length: _length,
                            isCampaign: isCampaign,
                            inStore: inStorePage,
                          );
                  },
                )
              : NoDataScreen(
                  text: noDataText ??
                      (isStore ? text : LocaleKeys.no_item_available.tr()))
          : GridView.builder(
              key: UniqueKey(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: Dimensions.paddingSizeLarge,
                mainAxisSpacing: ResponsiveHelper.isDesktop(context)
                    ? Dimensions.paddingSizeLarge
                    : 0.01,
                childAspectRatio: ResponsiveHelper.isDesktop(context)
                    ? 4
                    : showTheme1Store
                        ? 1.9
                        : 4,
                crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 2,
              ),
              physics: isScrollable
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              shrinkWrap: isScrollable ? false : true,
              itemCount: shimmerLength,
              padding: padding,
              itemBuilder: (context, index) {
                return showTheme1Store
                    ? StoreShimmer(isEnable: _isNull)
                    : ItemShimmer(
                        isEnabled: _isNull,
                        isStore: isStore,
                        hasDivider: index != shimmerLength - 1);
              },
            ),
    ]);
  }
}
