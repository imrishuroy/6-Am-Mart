import 'package:flutter/material.dart';
import 'package:six_am_mart/screens/parcel/parcel_screen.dart';
import 'package:six_am_mart/screens/store/store_screen.dart';
import '/screens/home/widgets/module_tile.dart';
import '../../../models/app_module.dart';
import '/config/urls.dart';

class ModuleView extends StatelessWidget {
  final List<AppModule?> modules;
  const ModuleView({
    Key? key,
    required this.modules,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: modules.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 6.0,
          childAspectRatio: 1.35,
        ),
        itemBuilder: (context, index) {
          final module = modules[index];
          final imageUrl = '${Urls.moduleImg}${module?.thumbnail}';
          print('MOdule name ppaa $module');

          return GestureDetector(
            onTap: () {
              if (module?.moduleName == 'Parcel') {
                // Naivigate to parcel screen
                Navigator.of(context).pushNamed(ParcelScreen.routeName);
              } else {
                if (module?.id != null) {
                  Navigator.of(context).pushNamed(StoreScreen.routeName,
                      arguments: StoreScreenArgs(id: module!.id.toString()));
                }
              }
            },
            child: ModuleTile(imageSrc: imageUrl),
          );
        },
      ),
    );
  }
}
