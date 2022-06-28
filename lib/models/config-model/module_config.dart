// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:six_am_mart/models/module.dart';

class ModuleConfig extends Equatable {
  final List<String?> moduleType;
  final Module? module;

  const ModuleConfig({
    required this.moduleType,
    required this.module,
  });

  ModuleConfig copyWith({
    List<String?>? moduleType,
    Module? module,
  }) {
    return ModuleConfig(
      moduleType: moduleType ?? this.moduleType,
      module: module ?? this.module,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'moduleType': moduleType,
      'module': module?.toMap(),
    };
  }

  factory ModuleConfig.fromMap(Map<String, dynamic> map) {
    return ModuleConfig(
      moduleType: List<String?>.from(
        (map['module_type'] as List<dynamic>),
      ),
      module: map['module'] != null
          ? Module.fromMap(map['module'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModuleConfig.fromJson(String source) =>
      ModuleConfig.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [moduleType, module];
}
