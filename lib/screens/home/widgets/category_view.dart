import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:six_am_mart/config/urls.dart';
import 'package:six_am_mart/models/category.dart';

import 'category_tile.dart';

class CategoryView extends StatelessWidget {
  final List<AppCategory?> categories;
  const CategoryView({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: SizedBox(
        height: categories.length * 74,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15.0,
            crossAxisSpacing: 12.0,
            childAspectRatio: 1.3,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];
            final imageUrl = '${Urls.categoryImg}${category?.image}';

            return CategoryTile(imageSrc: imageUrl);
          },
        ),
      ),
    );
  }
}
