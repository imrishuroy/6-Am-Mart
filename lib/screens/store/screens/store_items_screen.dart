import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:six_am_mart/models/item.dart';
import 'package:six_am_mart/screens/store/widgets/info_bar.dart';
import 'package:six_am_mart/screens/store/widgets/item_tile.dart';
import '/config/urls.dart';
import '/repositories/store/store_repository.dart';
import '/screens/store/cubit/store_cubit.dart';
import '/widgets/loading_indicator.dart';

import '/widgets/display_image.dart';
import '/models/store.dart';

class StoresItemsArgs {
  final Store? store;

  StoresItemsArgs({required this.store});
}

class StoresItemsScreen extends StatelessWidget {
  static const String routeName = '/storesItems';
  final Store? store;
  const StoresItemsScreen({Key? key, required this.store}) : super(key: key);

  static Route route({required StoresItemsArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider(
        create: (context) => StoreCubit(
          storeRepository: context.read<StoreRepository>(),
          moduleId: args.store?.moduleId.toString() ?? '1',
        )..loadCategories(storeId: args.store?.id),
        child: StoresItemsScreen(store: args.store),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Cover image  ${Urls.storeCoverImg}${store?.coverPhoto}');
    return Scaffold(
      body: BlocConsumer<StoreCubit, StoreState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == StoreStatus.loading) {
            return const LoadingIndicator();
          }
          return Column(
            children: [
              SizedBox(
                height: 280.0,
                child: Stack(
                  children: [
                    DisplayImage(
                      imageUrl: '${Urls.storeCoverImg}${store?.coverPhoto}',
                      height: 220.0,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      color: Colors.black38,
                      height: 220.0,
                    ),
                    const SizedBox(height: 30.0),
                    Positioned(
                      top: 140.0,
                      right: 20.0,
                      left: 20.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InfoBar(
                            label: '${store?.avgRating}',
                            icon: const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18.0,
                            ),
                          ),
                          const InfoBar(
                            label: 'Delivery',
                            icon: Icon(
                              Icons.bike_scooter,
                              color: Colors.white,
                              size: 18.0,
                            ),
                          ),
                          InfoBar(
                            label: 'Pickup',
                            icon: Container(
                              height: 15.0,
                              width: 15.0,
                              color: Colors.white,
                              child: Icon(
                                Icons.add,
                                color: Colors.grey.shade600,
                                size: 14.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 60.0,
                      right: 20.0,
                      left: 20.0,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30.0,
                            child: ClipOval(
                              child: DisplayImage(
                                imageUrl: '${Urls.storeLogoImg}${store?.logo}',
                                //height: 300.0,
                                height: 60.0,
                                width: 60.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15.0),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                store?.name ?? '',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                'Working Hours 10:30 - 11:30',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.notifications,
                              color: Colors.grey,
                            ),
                          ),
                          // SizedBox(width: 20.0)
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 15.0,
                      right: 20.0,
                      left: 20.0,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton.icon(
                                style: TextButton.styleFrom(
                                  primary: Colors.grey.shade600,
                                ),
                                onPressed: () {},
                                icon: const Icon(Icons.info),
                                label: const Text('Market Info'),
                              ),
                              TextButton.icon(
                                style: TextButton.styleFrom(
                                  primary: Colors.grey.shade600,
                                ),
                                onPressed: () {},
                                icon: const Icon(Icons.timer),
                                label: const Text('Delivery Time'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //const SizedBox(height: 10.0),
              Expanded(
                child: Container(
                  //  color: Colors.grey.shade100,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView.builder(
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      final category = state.categories[index];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category?.name ?? '',
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          CategoryItems(
                            categoryId: category?.id,
                            storeId: store?.id,
                            moduleId: store?.moduleId.toString() ?? '1',
                          ),
                          const SizedBox(height: 20.0)
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class CategoryItems extends StatefulWidget {
  final int? categoryId;
  final int? storeId;
  final String moduleId;

  const CategoryItems({
    super.key,
    this.categoryId,
    this.storeId,
    required this.moduleId,
  });

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  @override
  void initState() {
    // context.read<StoreCubit>().loadCategoryItems(
    //       moduleId: widget.moduleId,
    //       storeId: widget.storeId,
    //       categoryId: widget.categoryId,
    //     );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260.0,
      child: FutureBuilder<List<Item?>>(
        future: context.read<StoreRepository>().getStoreItems(
            moduleId: widget.moduleId,
            storeId: widget.storeId,
            categoryId: widget.categoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              final item = snapshot.data?[index];
              print('Item variations -- ${item?.variations}');

              return ItemTile(item: item);
            },
          );
        },
      ),
    );
  }
}
