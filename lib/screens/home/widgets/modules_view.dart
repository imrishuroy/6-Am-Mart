import 'package:flutter/material.dart';
import '/screens/home/widgets/module_tile.dart';
import '/models/module.dart';
import '/config/urls.dart';

class ModuleView extends StatelessWidget {
  final List<Module?> modules;
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
      child: SizedBox(
        height: modules.length * 87,
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

            return ModuleTile(imageSrc: imageUrl);
          },
        ),
      ),
    );
  }
}
