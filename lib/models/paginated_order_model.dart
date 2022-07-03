import 'package:equatable/equatable.dart';

import '/models/order_model.dart';

class PaginatedOrderModel extends Equatable {
  final int totalSize;
  final String limit;
  final int offset;
  final List<OrderModel?> orders;

  const PaginatedOrderModel({
    required this.totalSize,
    required this.limit,
    required this.offset,
    required this.orders,
  });

  PaginatedOrderModel copyWith({
    int? totalSize,
    String? limit,
    int? offset,
    List<OrderModel?>? orders,
  }) {
    return PaginatedOrderModel(
      totalSize: totalSize ?? this.totalSize,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      orders: orders ?? this.orders,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalSize': totalSize,
      'limit': limit,
      'offset': offset,
      'orders': orders.map((x) => x?.toMap()).toList(),
    };
  }

  factory PaginatedOrderModel.fromMap(Map<String, dynamic> map) {
    print('Map of paginated map $map');
    return PaginatedOrderModel(
      totalSize: map['total_size'] as int,
      limit: map['limit'] as String,
      offset:
          (map['offset'] != null && map['offset'].toString().trim().isNotEmpty)
              ? int.parse(map['offset'].toString())
              : 1,
      // offset: map['offset'] as int,

      orders: map['orders'] != null
          ? []
          : List<OrderModel?>.from(
              (map['orders'] as List<int>).map<OrderModel?>(
                (x) => OrderModel.fromMap(x as Map<String, dynamic>),
              ),
            ),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [totalSize, limit, offset, orders];
}
