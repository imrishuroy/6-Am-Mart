import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/store/widgets/item_tile.dart';
import '/models/item.dart';
import '/repositories/store/store_repository.dart';
import '/widgets/loading_indicator.dart';

class ViewAllItemsArgs {
  final String moduleId;
  final int? storeId;
  final int? categoryId;
  final String? categoryName;

  ViewAllItemsArgs({
    required this.moduleId,
    required this.storeId,
    required this.categoryId,
    required this.categoryName,
  });
}

class ViewAllItems extends StatelessWidget {
  final String moduleId;
  final int? storeId;
  final int? categoryId;
  final String? categoryName;

  static const String routeName = '/viewAllItems';

  const ViewAllItems({
    super.key,
    required this.moduleId,
    required this.storeId,
    required this.categoryId,
    required this.categoryName,
  });

  static Route route({required ViewAllItemsArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => ViewAllItems(
        categoryId: args.categoryId,
        categoryName: args.categoryName,
        moduleId: args.moduleId,
        storeId: args.storeId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          categoryName ?? 'N/A',
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 20.0,
        ),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Item?>>(
                future: context.read<StoreRepository>().getStoreItems(
                      moduleId: moduleId,
                      storeId: storeId,
                      categoryId: categoryId,
                    ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return GridView.builder(
                      itemCount: snapshot.data?.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 8.0,
                      ),
                      itemBuilder: (context, index) {
                        final item = snapshot.data?[index];
                        // final imgUrl = '${Urls.itemImage}${item?.image}';
                        return ItemTile(item: item);
                      },
                    );
                  }
                  return const LoadingIndicator();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
