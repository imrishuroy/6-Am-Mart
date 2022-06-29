import 'package:equatable/equatable.dart';

class ReviewBody extends Equatable {
  final String productId;
  final String deliveryManId;
  final String comment;
  final String rating;
  final List<String> fileUpload;
  final String orderId;

  const ReviewBody({
    required this.productId,
    required this.deliveryManId,
    required this.comment,
    required this.rating,
    required this.fileUpload,
    required this.orderId,
  });

  ReviewBody copyWith({
    String? productId,
    String? deliveryManId,
    String? comment,
    String? rating,
    List<String>? fileUpload,
    String? orderId,
  }) {
    return ReviewBody(
      productId: productId ?? this.productId,
      deliveryManId: deliveryManId ?? this.deliveryManId,
      comment: comment ?? this.comment,
      rating: rating ?? this.rating,
      fileUpload: fileUpload ?? this.fileUpload,
      orderId: orderId ?? this.orderId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'deliveryManId': deliveryManId,
      'comment': comment,
      'rating': rating,
      'fileUpload': fileUpload,
      'orderId': orderId,
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      productId,
      deliveryManId,
      comment,
      rating,
      fileUpload,
      orderId,
    ];
  }
}
