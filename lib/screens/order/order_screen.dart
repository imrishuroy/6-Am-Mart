import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:six_am_mart/blocs/order/order_cubit.dart';
import '/blocs/auth/auth_bloc.dart';
import '/helpers/dimensions.dart';
import '/helpers/responsive_helper.dart';
import '/translations/locale_keys.g.dart';
import '/utils/utils.dart';
import '/widgets/custom_appbar.dart';
import '/widgets/menu_drawer.dart';
import '/widgets/not_login_screen.dart';
import 'widgets/order_view.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    _isLoggedIn = context.read<AuthBloc>().state.isLoggedIn();

    // _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if (_isLoggedIn) {
      _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
      context.read<OrderCubit>().getRunningOrders(1);
      // Get.find<OrderController>().getRunningOrders(1);
      // Get.find<OrderController>().getHistoryOrders(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: LocaleKeys.my_orders.tr(),
          backButton: ResponsiveHelper.isDesktop(context)),
      endDrawer: const MenuDrawer(),
      body: _isLoggedIn
          ? BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
              return Column(children: [
                Center(
                  child: Container(
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
                      tabs: [
                        Tab(
                          text: LocaleKeys.rating.tr(),
                        ),
                        Tab(
                          text: LocaleKeys.history.tr(),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: TabBarView(
                  controller: _tabController,
                  children: const [
                    OrderView(isRunning: true),
                    OrderView(isRunning: false),
                  ],
                )),
              ]);
            })
          : const NotLoggedInScreen(),
    );
  }
}
