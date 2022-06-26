import 'dart:convert';

import 'package:equatable/equatable.dart';

class AddressModel extends Equatable {
  final int? id;
  final String? addressType;
  final String? contactPersonNumber;
  final String? address;
  final String? additionalAddress;
  final String? latitude;
  final String? longitude;
  final int? zoneId;
  final List<int?>? zoneIds;
  final String? method;
  final String? contactPersonName;
  final String? streetNumber;
  final String? house;
  final String? floor;

  const AddressModel({
    this.id,
    this.addressType,
    this.contactPersonNumber,
    this.address,
    this.additionalAddress,
    this.latitude,
    this.longitude,
    this.zoneId,
    this.zoneIds,
    this.method,
    this.contactPersonName,
    this.streetNumber,
    this.house,
    this.floor,
  });

  AddressModel copyWith({
    int? id,
    String? addressType,
    String? contactPersonNumber,
    String? address,
    String? additionalAddress,
    String? latitude,
    String? longitude,
    int? zoneId,
    List<int?>? zoneIds,
    String? method,
    String? contactPersonName,
    String? streetNumber,
    String? house,
    String? floor,
  }) {
    return AddressModel(
      id: id ?? this.id,
      addressType: addressType ?? this.addressType,
      contactPersonNumber: contactPersonNumber ?? this.contactPersonNumber,
      address: address ?? this.address,
      additionalAddress: additionalAddress ?? this.additionalAddress,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      zoneId: zoneId ?? this.zoneId,
      zoneIds: zoneIds ?? this.zoneIds,
      method: method ?? this.method,
      contactPersonName: contactPersonName ?? this.contactPersonName,
      streetNumber: streetNumber ?? this.streetNumber,
      house: house ?? this.house,
      floor: floor ?? this.floor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address_type': addressType,
      'contact_person_number': contactPersonNumber,
      'address': address,
      'additional_address': additionalAddress,
      'latitude': latitude,
      'longitude': longitude,
      'zone_id': zoneId,
      // 'zoneIds': zoneIds?.map((x) => x?.toMap())?.toList(),
      'zoneIds': zoneIds,
      '_method': method,
      'contact_person_name': contactPersonName,
      'streetNumber': streetNumber,
      'house': house,
      'floor': floor,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id']?.toInt(),
      addressType: map['address_type'],
      contactPersonNumber: map['contact_person_number'],
      address: map['additional_address'],
      additionalAddress: map['additionalAddress'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      zoneId: map['zone_id']?.toInt(),
      zoneIds: map['zone_ids'] != null ? map['zone_ids'].cast<int?>() : [],
      method: map['_method'],
      contactPersonName: map['contact_person_name'],
      streetNumber: map['road'],
      house: map['house'],
      floor: map['floor'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddressModel(id: $id, addressType: $addressType, contactPersonNumber: $contactPersonNumber, address: $address, additionalAddress: $additionalAddress, latitude: $latitude, longitude: $longitude, zoneId: $zoneId, zoneIds: $zoneIds, method: $method, contactPersonName: $contactPersonName, streetNumber: $streetNumber, house: $house, floor: $floor)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      addressType,
      contactPersonNumber,
      address,
      additionalAddress,
      latitude,
      longitude,
      zoneId,
      zoneIds,
      method,
      contactPersonName,
      streetNumber,
      house,
      floor,
    ];
  }
}
