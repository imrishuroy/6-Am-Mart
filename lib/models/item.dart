import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:six_am_mart/models/unit.dart';
import '/models/category_ids.dart';
import '/models/variation.dart';
import 'add_ons.dart';
import 'choice_options.dart';

class Item extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? image;
  final List<String?> images;
  final int? categoryId;
  final List<CategoryIds?> categoryIds;
  final List<Variation?> variations;
  final List<AddOns?> addOns;
  final List<ChoiceOptions?> choiceOptions;
  final double? price;
  final double? tax;
  final double? discount;
  final String? discountType;
  final String? availableTimeStarts;
  final String? availableTimeEnds;
  final int? storeId;
  final String? storeName;
  final double? storeDiscount;
  final bool? scheduleOrder;
  final double? avgRating;
  final int? ratingCount;
  final int? veg;
  final int? moduleId;
  final String? unitType;
  final Unit? unit;
  final int? stock;
  final String? availableDateStarts;
  const Item({
    this.id,
    this.name,
    this.description,
    this.image,
    required this.images,
    this.categoryId,
    required this.categoryIds,
    required this.variations,
    required this.addOns,
    required this.choiceOptions,
    this.price,
    this.tax,
    this.discount,
    this.discountType,
    this.availableTimeStarts,
    this.availableTimeEnds,
    this.storeId,
    this.storeName,
    this.storeDiscount,
    this.scheduleOrder,
    this.avgRating,
    this.ratingCount,
    this.veg,
    this.moduleId,
    this.unitType,
    this.unit,
    this.stock,
    this.availableDateStarts,
  });

  Item copyWith({
    int? id,
    String? name,
    String? description,
    String? image,
    List<String?>? images,
    int? categoryId,
    List<CategoryIds?>? categoryIds,
    List<Variation?>? variations,
    List<AddOns?>? addOns,
    List<ChoiceOptions?>? choiceOptions,
    double? price,
    double? tax,
    double? discount,
    String? discountType,
    String? availableTimeStarts,
    String? availableTimeEnds,
    int? storeId,
    String? storeName,
    double? storeDiscount,
    bool? scheduleOrder,
    double? avgRating,
    int? ratingCount,
    int? veg,
    int? moduleId,
    String? unitType,
    int? stock,
    String? availableDateStarts,
    Unit? unit,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      images: images ?? this.images,
      categoryId: categoryId ?? this.categoryId,
      categoryIds: categoryIds ?? this.categoryIds,
      variations: variations ?? this.variations,
      addOns: addOns ?? this.addOns,
      choiceOptions: choiceOptions ?? this.choiceOptions,
      price: price ?? this.price,
      tax: tax ?? this.tax,
      discount: discount ?? this.discount,
      discountType: discountType ?? this.discountType,
      availableTimeStarts: availableTimeStarts ?? this.availableTimeStarts,
      availableTimeEnds: availableTimeEnds ?? this.availableTimeEnds,
      storeId: storeId ?? this.storeId,
      storeName: storeName ?? this.storeName,
      storeDiscount: storeDiscount ?? this.storeDiscount,
      scheduleOrder: scheduleOrder ?? this.scheduleOrder,
      avgRating: avgRating ?? this.avgRating,
      ratingCount: ratingCount ?? this.ratingCount,
      veg: veg ?? this.veg,
      moduleId: moduleId ?? this.moduleId,
      unitType: unitType ?? this.unitType,
      stock: stock ?? this.stock,
      availableDateStarts: availableDateStarts ?? this.availableDateStarts,
      unit: unit ?? this.unit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'images': images,
      'categoryId': categoryId,
      'categoryIds': categoryIds.map((x) => x?.toMap()).toList(),
      'variations': variations.map((x) => x?.toMap()).toList(),
      'addOns': addOns.map((x) => x?.toMap()).toList(),
      'choiceOptions': choiceOptions.map((x) => x?.toMap()).toList(),
      'price': price,
      'tax': tax,
      'discount': discount,
      'discountType': discountType,
      'availableTimeStarts': availableTimeStarts,
      'availableTimeEnds': availableTimeEnds,
      'storeId': storeId,
      'storeName': storeName,
      'storeDiscount': storeDiscount,
      'scheduleOrder': scheduleOrder,
      'avgRating': avgRating,
      'ratingCount': ratingCount,
      'veg': veg,
      'moduleId': moduleId,
      'unitType': unitType,
      'stock': stock,
      'availableDateStarts': availableDateStarts,
      'unit': unit,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id']?.toInt(),
      name: map['name'],
      description: map['description'],
      image: map['image'],
      images: List<String?>.from(map['images']),
      categoryId: map['category_id']?.toInt(),
      categoryIds: map['category_ids'] != null
          ? List<CategoryIds?>.from(
              map['category_ids']?.map((x) => CategoryIds.fromMap(x)))
          : [],
      variations: map['variations'] != null
          ? List<Variation?>.from(
              map['variations']?.map((x) => Variation.fromMap(x)))
          : [],
      addOns: map['add_ons'] != null
          ? List<AddOns?>.from(map['add_ons']?.map((x) => AddOns.fromMap(x)))
          : [],
      choiceOptions: map['choice_options'] != null
          ? List<ChoiceOptions?>.from(
              map['choice_options']?.map((x) => ChoiceOptions.fromMap(x)))
          : [],
      price: map['price']?.toDouble(),
      tax: map['tax']?.toDouble(),
      discount: map['discount']?.toDouble(),
      discountType: map['discount_type'],
      availableTimeStarts: map['available_time_starts'],
      availableTimeEnds: map['available_time_ends'],
      storeId: map['storeId']?.toInt(),
      storeName: map['store_name'],
      storeDiscount: map['store_discount']?.toDouble(),
      scheduleOrder: map['schedule_order'],
      avgRating: map['avg_rating']?.toDouble(),
      ratingCount: map['rating_count']?.toInt(),
      veg: map['veg']?.toInt(),
      moduleId: map['module_id']?.toInt(),
      unitType: map['unit_type'],
      stock: map['stock']?.toInt(),
      unit: map['unit'] != null ? Unit.fromMap(map['unit']) : null,
      // availableDateStarts: map['availableDateStarts'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Item(id: $id, name: $name, description: $description, image: $image, images: $images, categoryId: $categoryId, categoryIds: $categoryIds, variations: $variations, addOns: $addOns, choiceOptions: $choiceOptions, price: $price, tax: $tax, discount: $discount, discountType: $discountType, availableTimeStarts: $availableTimeStarts, availableTimeEnds: $availableTimeEnds, storeId: $storeId, storeName: $storeName, storeDiscount: $storeDiscount, scheduleOrder: $scheduleOrder, avgRating: $avgRating, ratingCount: $ratingCount, veg: $veg, moduleId: $moduleId, unitType: $unitType, stock: $stock, availableDateStarts: $availableDateStarts)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
      image,
      images,
      categoryId,
      categoryIds,
      variations,
      addOns,
      choiceOptions,
      price,
      tax,
      discount,
      discountType,
      availableTimeStarts,
      availableTimeEnds,
      storeId,
      storeName,
      storeDiscount,
      scheduleOrder,
      avgRating,
      ratingCount,
      veg,
      moduleId,
      unitType,
      stock,
      availableDateStarts,
    ];
  }
}
