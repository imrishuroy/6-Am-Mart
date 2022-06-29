import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '/blocs/config/app_config_bloc.dart';
import '/widgets/not_login_screen.dart';
import '/blocs/auth/auth_bloc.dart';
import '/helpers/dimensions.dart';
import '/utils/utils.dart';
import '/widgets/menu_drawer.dart';
import '/translations/locale_keys.g.dart';
import '/widgets/custom_appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/fav_item_view.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  FavouriteScreenState createState() => FavouriteScreenState();
}

class FavouriteScreenState extends State<FavouriteScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final configBloc = context.read<AppConfigBloc>();

    String text = LocaleKeys.store.tr();

    bool showRestaurant =
        configBloc.state.config?.moduleConfig?.module?.showRestaurantText ??
            false;

    if (showRestaurant) {
      text = LocaleKeys.restaurant.tr();
    }

    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.favourite.tr(), backButton: false),
      endDrawer: const MenuDrawer(),
      body: authBloc.state.isLoggedIn()
          ? SafeArea(
              child: Column(
                children: [
                  Container(
                    width: Dimensions.webMaxWidth,
                    color: Theme.of(context).cardColor,
                    child: TabBar(
                      controller: _tabController,
                      indicatorColor: Theme.of(context).primaryColor,
                      indicatorWeight: 3,
                      labelColor: Theme.of(context).primaryColor,
                      unselectedLabelColor: Theme.of(context).disabledColor,
                      unselectedLabelStyle: robotoRegular.copyWith(
                          color: Theme.of(context).disabledColor,
                          fontSize: Dimensions.fontSizeSmall),
                      labelStyle: robotoBold.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).primaryColor),
                      tabs: [Tab(text: LocaleKeys.item.tr()), Tab(text: text)],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: const [
                        FavItemView(isStore: false),
                        FavItemView(isStore: true),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const NotLoggedInScreen(),
    );
  }
}
