import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? name;
  final String? userId;

  const User({
    this.name,
    this.userId,
  });

  static const emptyUser = User();

  User copyWith({
    String? name,
    String? userId,
  }) {
    return User(
      name: name ?? this.name,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'userId': userId,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      userId: map['userId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(name: $name, userId: $userId)';

  @override
  List<Object?> get props => [name, userId];
}
