import 'dart:convert';
import 'package:equatable/equatable.dart';

class BaseUrls extends Equatable {
  final String? itemImageUrl;
  final String? customerImageUrl;
  final String? bannerImageUrl;
  final String? categoryImageUrl;
  final String? reviewImageUrl;
  final String? notificationImageUrl;
  final String? vendorImageUrl;
  final String? storeImageUrl;
  final String? storeCoverPhotoUrl;
  final String? deliveryManImageUrl;
  final String? chatImageUrl;
  final String? campaignImageUrl;
  final String? moduleImageUrl;
  final String? orderAttachmentUrl;
  final String? parcelCategoryImageUrl;
  final String? landingPageImageUrl;

  const BaseUrls({
    this.itemImageUrl,
    this.customerImageUrl,
    this.bannerImageUrl,
    this.categoryImageUrl,
    this.reviewImageUrl,
    this.notificationImageUrl,
    this.vendorImageUrl,
    this.storeImageUrl,
    this.storeCoverPhotoUrl,
    this.deliveryManImageUrl,
    this.chatImageUrl,
    this.campaignImageUrl,
    this.moduleImageUrl,
    this.orderAttachmentUrl,
    this.parcelCategoryImageUrl,
    this.landingPageImageUrl,
  });

  BaseUrls copyWith({
    String? itemImageUrl,
    String? customerImageUrl,
    String? bannerImageUrl,
    String? categoryImageUrl,
    String? reviewImageUrl,
    String? notificationImageUrl,
    String? vendorImageUrl,
    String? storeImageUrl,
    String? storeCoverPhotoUrl,
    String? deliveryManImageUrl,
    String? chatImageUrl,
    String? campaignImageUrl,
    String? moduleImageUrl,
    String? orderAttachmentUrl,
    String? parcelCategoryImageUrl,
    String? landingPageImageUrl,
  }) {
    return BaseUrls(
      itemImageUrl: itemImageUrl ?? this.itemImageUrl,
      customerImageUrl: customerImageUrl ?? this.customerImageUrl,
      bannerImageUrl: bannerImageUrl ?? this.bannerImageUrl,
      categoryImageUrl: categoryImageUrl ?? this.categoryImageUrl,
      reviewImageUrl: reviewImageUrl ?? this.reviewImageUrl,
      notificationImageUrl: notificationImageUrl ?? this.notificationImageUrl,
      vendorImageUrl: vendorImageUrl ?? this.vendorImageUrl,
      storeImageUrl: storeImageUrl ?? this.storeImageUrl,
      storeCoverPhotoUrl: storeCoverPhotoUrl ?? this.storeCoverPhotoUrl,
      deliveryManImageUrl: deliveryManImageUrl ?? this.deliveryManImageUrl,
      chatImageUrl: chatImageUrl ?? this.chatImageUrl,
      campaignImageUrl: campaignImageUrl ?? this.campaignImageUrl,
      moduleImageUrl: moduleImageUrl ?? this.moduleImageUrl,
      orderAttachmentUrl: orderAttachmentUrl ?? this.orderAttachmentUrl,
      parcelCategoryImageUrl:
          parcelCategoryImageUrl ?? this.parcelCategoryImageUrl,
      landingPageImageUrl: landingPageImageUrl ?? this.landingPageImageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemImageUrl': itemImageUrl,
      'customerImageUrl': customerImageUrl,
      'bannerImageUrl': bannerImageUrl,
      'categoryImageUrl': categoryImageUrl,
      'reviewImageUrl': reviewImageUrl,
      'notificationImageUrl': notificationImageUrl,
      'vendorImageUrl': vendorImageUrl,
      'storeImageUrl': storeImageUrl,
      'storeCoverPhotoUrl': storeCoverPhotoUrl,
      'deliveryManImageUrl': deliveryManImageUrl,
      'chatImageUrl': chatImageUrl,
      'campaignImageUrl': campaignImageUrl,
      'moduleImageUrl': moduleImageUrl,
      'orderAttachmentUrl': orderAttachmentUrl,
      'parcelCategoryImageUrl': parcelCategoryImageUrl,
      'landingPageImageUrl': landingPageImageUrl,
    };
  }

  factory BaseUrls.fromMap(Map<String, dynamic> map) {
    return BaseUrls(
      itemImageUrl: map['item_image_url'] != null
          ? map['item_image_url'] as String
          : null,
      customerImageUrl: map['customer_image_url'] != null
          ? map['customer_image_url'] as String
          : null,
      bannerImageUrl: map['banner_image_url'] != null
          ? map['banner_image_url'] as String
          : null,
      categoryImageUrl: map['category_image_url'] != null
          ? map['category_image_url'] as String
          : null,
      reviewImageUrl: map['review_image_url'] != null
          ? map['review_image_url'] as String
          : null,
      notificationImageUrl: map['notification_image_url'] != null
          ? map['notification_image_url'] as String
          : null,
      vendorImageUrl: map['vendor_image_url'] != null
          ? map['vendor_image_url'] as String
          : null,
      storeImageUrl: map['store_image_url'] != null
          ? map['store_image_url'] as String
          : null,
      storeCoverPhotoUrl: map['store_cover_photo_url'] != null
          ? map['store_cover_photo_url'] as String
          : null,
      deliveryManImageUrl: map['delivery_man_image_url'] != null
          ? map['delivery_man_image_url'] as String
          : null,
      chatImageUrl: map['chat_image_url'] != null
          ? map['chat_image_url'] as String
          : null,
      campaignImageUrl: map['campaign_image_url'] != null
          ? map['campaign_image_url'] as String
          : null,
      moduleImageUrl: map['module_image_url'] != null
          ? map['module_image_url'] as String
          : null,
      orderAttachmentUrl: map['order_attachment_url'] != null
          ? map['order_attachment_url'] as String
          : null,
      parcelCategoryImageUrl: map['parcel_category_image_url'] != null
          ? map['parcel_category_image_url'] as String
          : null,
      landingPageImageUrl: map['landing_page_image_url'] != null
          ? map['landing_page_image_url'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BaseUrls.fromJson(String source) =>
      BaseUrls.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      itemImageUrl,
      customerImageUrl,
      bannerImageUrl,
      categoryImageUrl,
      reviewImageUrl,
      notificationImageUrl,
      vendorImageUrl,
      storeImageUrl,
      storeCoverPhotoUrl,
      deliveryManImageUrl,
      chatImageUrl,
      campaignImageUrl,
      moduleImageUrl,
      orderAttachmentUrl,
      parcelCategoryImageUrl,
      landingPageImageUrl,
    ];
  }
}
