import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:six_am_mart/models/item.dart';

class ItemModel extends Equatable {
  final int totalSize;
  final String limit;
  final int? offset;
  final List<Item> items;

  const ItemModel({
    required this.totalSize,
    required this.limit,
    required this.offset,
    required this.items,
  });

  ItemModel copyWith({
    int? totalSize,
    String? limit,
    int? offset,
    List<Item>? items,
  }) {
    return ItemModel(
      totalSize: totalSize ?? this.totalSize,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalSize': totalSize,
      'limit': limit,
      'offset': offset,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      totalSize: map['total_size'] as int,
      limit: map['limit'] as String,
      offset:
          (map['offset'] != null && map['offset'].toString().trim().isNotEmpty)
              ? int.parse(map['offset'].toString())
              : null,
      items: map['products'] != null
          ? List<Item>.from(
              (map['products'] as List<int>).map<Item>(
                (x) => Item.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [totalSize, limit, offset, items];
}
