// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'base_urls.dart';
import 'default_location.dart';
import 'landing_page_links.dart';
import 'language.dart';
import 'language_page_setting.dart';
import 'module_config.dart';
import 'module_model.dart';
import 'social_media.dart';

class ConfigModel extends Equatable {
  final String? businessName;
  final String? logo;
  final String? address;
  final String? phone;
  final String? email;
  final BaseUrls? baseUrls;
  final String? country;
  final DefaultLocation defaultLocation;
  final String? currencySymbol;
  final String? currencySymbolDirection;
  final int? appMinimumVersionAndroid;
  final String? appUrlAndroid;
  final int? appMinimumVersionIos;
  final String? appUrlIos;
  final bool? customerVerification;
  final bool? scheduleOrder;
  final bool? orderDeliveryVerification;
  final bool? cashOnDelivery;
  final bool? digitalPayment;
  final int? perKmShippingCharge;
  final int? minimumShippingCharge;
  final int? freeDeliveryOver;
  final bool? demo;
  final bool? maintenanceMode;
  final String? orderConfirmationModel;
  final bool? showDmEarning;
  final bool? canceledByDeliveryman;
  final String? timeformat;
  final List<Language> language;
  final bool? toggleVegNonVeg;
  final bool? toggleDmRegistration;
  final bool? toggleStoreRegistration;
  final int? scheduleOrderSlotDuration;
  final int? digitAfterDecimalPoint;
  final int? parcelPerKmShippingCharge;
  final int? parcelMinimumShippingCharge;
  final ModuleModel? module;
  final ModuleConfig? moduleConfig;
  final LandingPageSettings? landingPageSettings;
  final List<SocialMedia?> socialMedia;
  final String? footerText;
  final LandingPageLinks? landingPageLinks;

  const ConfigModel({
    this.businessName,
    this.logo,
    this.address,
    this.phone,
    this.email,
    this.baseUrls,
    this.country,
    required this.defaultLocation,
    this.currencySymbol,
    this.currencySymbolDirection,
    this.appMinimumVersionAndroid,
    this.appUrlAndroid,
    this.appMinimumVersionIos,
    this.appUrlIos,
    this.customerVerification,
    this.scheduleOrder,
    this.orderDeliveryVerification,
    this.cashOnDelivery,
    this.digitalPayment,
    this.perKmShippingCharge,
    this.minimumShippingCharge,
    this.freeDeliveryOver,
    this.demo,
    this.maintenanceMode,
    this.orderConfirmationModel,
    this.showDmEarning,
    this.canceledByDeliveryman,
    this.timeformat,
    required this.language,
    this.toggleVegNonVeg,
    this.toggleDmRegistration,
    this.toggleStoreRegistration,
    this.scheduleOrderSlotDuration,
    this.digitAfterDecimalPoint,
    this.parcelPerKmShippingCharge,
    this.parcelMinimumShippingCharge,
    this.module,
    this.moduleConfig,
    this.landingPageSettings,
    required this.socialMedia,
    this.footerText,
    this.landingPageLinks,
  });

  ConfigModel copyWith({
    String? businessName,
    String? logo,
    String? address,
    String? phone,
    String? email,
    BaseUrls? baseUrls,
    String? country,
    DefaultLocation? defaultLocation,
    String? currencySymbol,
    String? currencySymbolDirection,
    int? appMinimumVersionAndroid,
    String? appUrlAndroid,
    int? appMinimumVersionIos,
    String? appUrlIos,
    bool? customerVerification,
    bool? scheduleOrder,
    bool? orderDeliveryVerification,
    bool? cashOnDelivery,
    bool? digitalPayment,
    int? perKmShippingCharge,
    int? minimumShippingCharge,
    int? freeDeliveryOver,
    bool? demo,
    bool? maintenanceMode,
    String? orderConfirmationModel,
    bool? showDmEarning,
    bool? canceledByDeliveryman,
    String? timeformat,
    List<Language>? language,
    bool? toggleVegNonVeg,
    bool? toggleDmRegistration,
    bool? toggleStoreRegistration,
    int? scheduleOrderSlotDuration,
    int? digitAfterDecimalPoint,
    int? parcelPerKmShippingCharge,
    int? parcelMinimumShippingCharge,
    ModuleModel? module,
    ModuleConfig? moduleConfig,
    LandingPageSettings? landingPageSettings,
    List<SocialMedia?>? socialMedia,
    String? footerText,
    LandingPageLinks? landingPageLinks,
  }) {
    return ConfigModel(
      businessName: businessName ?? this.businessName,
      logo: logo ?? this.logo,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      baseUrls: baseUrls ?? this.baseUrls,
      country: country ?? this.country,
      defaultLocation: defaultLocation ?? this.defaultLocation,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencySymbolDirection:
          currencySymbolDirection ?? this.currencySymbolDirection,
      appMinimumVersionAndroid:
          appMinimumVersionAndroid ?? this.appMinimumVersionAndroid,
      appUrlAndroid: appUrlAndroid ?? this.appUrlAndroid,
      appMinimumVersionIos: appMinimumVersionIos ?? this.appMinimumVersionIos,
      appUrlIos: appUrlIos ?? this.appUrlIos,
      customerVerification: customerVerification ?? this.customerVerification,
      scheduleOrder: scheduleOrder ?? this.scheduleOrder,
      orderDeliveryVerification:
          orderDeliveryVerification ?? this.orderDeliveryVerification,
      cashOnDelivery: cashOnDelivery ?? this.cashOnDelivery,
      digitalPayment: digitalPayment ?? this.digitalPayment,
      perKmShippingCharge: perKmShippingCharge ?? this.perKmShippingCharge,
      minimumShippingCharge:
          minimumShippingCharge ?? this.minimumShippingCharge,
      freeDeliveryOver: freeDeliveryOver ?? this.freeDeliveryOver,
      demo: demo ?? this.demo,
      maintenanceMode: maintenanceMode ?? this.maintenanceMode,
      orderConfirmationModel:
          orderConfirmationModel ?? this.orderConfirmationModel,
      showDmEarning: showDmEarning ?? this.showDmEarning,
      canceledByDeliveryman:
          canceledByDeliveryman ?? this.canceledByDeliveryman,
      timeformat: timeformat ?? this.timeformat,
      language: language ?? this.language,
      toggleVegNonVeg: toggleVegNonVeg ?? this.toggleVegNonVeg,
      toggleDmRegistration: toggleDmRegistration ?? this.toggleDmRegistration,
      toggleStoreRegistration:
          toggleStoreRegistration ?? this.toggleStoreRegistration,
      scheduleOrderSlotDuration:
          scheduleOrderSlotDuration ?? this.scheduleOrderSlotDuration,
      digitAfterDecimalPoint:
          digitAfterDecimalPoint ?? this.digitAfterDecimalPoint,
      parcelPerKmShippingCharge:
          parcelPerKmShippingCharge ?? this.parcelPerKmShippingCharge,
      parcelMinimumShippingCharge:
          parcelMinimumShippingCharge ?? this.parcelMinimumShippingCharge,
      module: module ?? this.module,
      moduleConfig: moduleConfig ?? this.moduleConfig,
      landingPageSettings: landingPageSettings ?? this.landingPageSettings,
      socialMedia: socialMedia ?? this.socialMedia,
      footerText: footerText ?? this.footerText,
      landingPageLinks: landingPageLinks ?? this.landingPageLinks,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'businessName': businessName,
      'logo': logo,
      'address': address,
      'phone': phone,
      'email': email,
      'baseUrls': baseUrls?.toMap(),
      'country': country,
      'defaultLocation': defaultLocation.toMap(),
      'currencySymbol': currencySymbol,
      'currencySymbolDirection': currencySymbolDirection,
      'appMinimumVersionAndroid': appMinimumVersionAndroid,
      'appUrlAndroid': appUrlAndroid,
      'appMinimumVersionIos': appMinimumVersionIos,
      'appUrlIos': appUrlIos,
      'customerVerification': customerVerification,
      'scheduleOrder': scheduleOrder,
      'orderDeliveryVerification': orderDeliveryVerification,
      'cashOnDelivery': cashOnDelivery,
      'digitalPayment': digitalPayment,
      'perKmShippingCharge': perKmShippingCharge,
      'minimumShippingCharge': minimumShippingCharge,
      'freeDeliveryOver': freeDeliveryOver,
      'demo': demo,
      'maintenanceMode': maintenanceMode,
      'orderConfirmationModel': orderConfirmationModel,
      'showDmEarning': showDmEarning,
      'canceledByDeliveryman': canceledByDeliveryman,
      'timeformat': timeformat,
      'language': language.map((x) => x.toMap()).toList(),
      'toggleVegNonVeg': toggleVegNonVeg,
      'toggleDmRegistration': toggleDmRegistration,
      'toggleStoreRegistration': toggleStoreRegistration,
      'scheduleOrderSlotDuration': scheduleOrderSlotDuration,
      'digitAfterDecimalPoint': digitAfterDecimalPoint,
      'parcelPerKmShippingCharge': parcelPerKmShippingCharge,
      'parcelMinimumShippingCharge': parcelMinimumShippingCharge,
      'module': module?.toMap(),
      'moduleConfig': moduleConfig?.toMap(),
      'landingPageSettings': landingPageSettings?.toMap(),
      'socialMedia': socialMedia.map((x) => x?.toMap()).toList(),
      'footerText': footerText,
      'landingPageLinks': landingPageLinks?.toMap(),
    };
  }

  factory ConfigModel.fromMap(Map<String, dynamic> map) {
    return ConfigModel(
      businessName:
          map['business_name'] != null ? map['business_name'] as String : null,
      logo: map['logo'] != null ? map['logo'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      baseUrls: map['base_urls'] != null
          ? BaseUrls.fromMap(map['base_urls'] as Map<String, dynamic>)
          : null,
      country: map['country'] != null ? map['country'] as String : null,
      defaultLocation: DefaultLocation.fromMap(
          map['default_location'] as Map<String, dynamic>),
      currencySymbol: map['currency_symbol'] != null
          ? map['currency_symbol'] as String
          : null,
      currencySymbolDirection: map['currency_symbol_direction'] != null
          ? map['currency_symbol_direction'] as String
          : null,
      appMinimumVersionAndroid: map['app_minimum_version_android'] != null
          ? map['app_minimum_version_android'] as int
          : null,
      appUrlAndroid: map['app_url_android'] != null
          ? map['app_url_android'] as String
          : null,
      appMinimumVersionIos: map['app_minimum_version_ios'] != null
          ? map['app_minimum_version_ios'] as int
          : null,
      appUrlIos:
          map['app_url_ios'] != null ? map['app_url_ios'] as String : null,
      customerVerification: map['customer_verification'] != null
          ? map['customer_verification'] as bool
          : null,
      scheduleOrder:
          map['schedule_order'] != null ? map['schedule_order'] as bool : null,
      orderDeliveryVerification: map['order_delivery_verification'] != null
          ? map['order_delivery_verification'] as bool
          : null,
      cashOnDelivery: map['cash_on_delivery'] != null
          ? map['cash_on_delivery'] as bool
          : null,
      digitalPayment: map['digital_payment'] != null
          ? map['digital_payment'] as bool
          : null,
      perKmShippingCharge: map['per_km_shipping_charge'] != null
          ? map['per_km_shipping_charge'] as int?
          : null,
      minimumShippingCharge: map['minimum_shipping_charge'] != null
          ? map['minimum_shipping_charge'] as int
          : null,
      freeDeliveryOver: map['free_delivery_over'] != null
          ? map['free_delivery_over'] as int
          : null,
      demo: map['demo'] != null ? map['demo'] as bool : null,
      maintenanceMode: map['maintenance_mode'] != null
          ? map['maintenance_mode'] as bool
          : null,
      orderConfirmationModel: map['order_confirmation_model'] != null
          ? map['order_confirmation_model'] as String
          : null,
      showDmEarning: map['show_dm_earning'] != null
          ? map['show_dm_earning'] as bool
          : null,
      canceledByDeliveryman: map['canceled_by_deliveryman'] != null
          ? map['canceled_by_deliveryman'] as bool
          : null,
      timeformat:
          map['timeformat'] != null ? map['timeformat'] as String : null,
      language: List<Language>.from(
        (map['language'] as List<dynamic>).map<Language>(
          (x) => Language.fromMap(x as Map<String, dynamic>),
        ),
      ),
      toggleVegNonVeg: map['toggle_veg_non_veg'] != null
          ? map['toggle_veg_non_veg'] as bool
          : null,
      toggleDmRegistration: map['toggle_dm_registration'] != null
          ? map['toggle_dm_registration'] as bool
          : null,
      toggleStoreRegistration: map['toggle_store_registration'] != null
          ? map['toggle_store_registration'] as bool
          : null,
      scheduleOrderSlotDuration: map['schedule_order_slot_duration'] != null
          ? map['schedule_order_slot_duration'] as int
          : null,
      digitAfterDecimalPoint: map['digit_after_decimal_point'] != null
          ? map['digit_after_decimal_point'] as int
          : null,
      parcelPerKmShippingCharge: map['parcel_per_km_shipping_charge'] != null
          ? map['parcel_per_km_shipping_charge'] as int
          : null,
      parcelMinimumShippingCharge: map['parcel_minimum_shipping_charge'] != null
          ? map['parcel_minimum_shipping_charge'] as int
          : null,
      module: map['module'] != null
          ? ModuleModel.fromMap(map['module'] as Map<String, dynamic>)
          : null,
      moduleConfig: map['module_config'] != null
          ? ModuleConfig.fromMap(map['module_config'] as Map<String, dynamic>)
          : null,
      landingPageSettings: map['landing_page_settings'] != null
          ? LandingPageSettings.fromMap(
              map['landing_page_settings'] as Map<String, dynamic>)
          : null,
      socialMedia: List<SocialMedia?>.from(
        (map['social_media'] as List<dynamic>).map<SocialMedia?>(
          (x) => SocialMedia.fromMap(x as Map<String, dynamic>),
        ),
      ),
      footerText:
          map['footer_text'] != null ? map['footer_text'] as String : null,
      landingPageLinks: map['landing_page_links'] != null
          ? LandingPageLinks.fromMap(
              map['landing_page_links'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfigModel.fromJson(String source) =>
      ConfigModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      businessName,
      logo,
      address,
      phone,
      email,
      baseUrls,
      country,
      defaultLocation,
      currencySymbol,
      currencySymbolDirection,
      appMinimumVersionAndroid,
      appUrlAndroid,
      appMinimumVersionIos,
      appUrlIos,
      customerVerification,
      scheduleOrder,
      orderDeliveryVerification,
      cashOnDelivery,
      digitalPayment,
      perKmShippingCharge,
      minimumShippingCharge,
      freeDeliveryOver,
      demo,
      maintenanceMode,
      orderConfirmationModel,
      showDmEarning,
      canceledByDeliveryman,
      timeformat,
      language,
      toggleVegNonVeg,
      toggleDmRegistration,
      toggleStoreRegistration,
      scheduleOrderSlotDuration,
      digitAfterDecimalPoint,
      parcelPerKmShippingCharge,
      parcelMinimumShippingCharge,
      module,
      moduleConfig,
      landingPageSettings,
      socialMedia,
      footerText,
      landingPageLinks,
    ];
  }
}
