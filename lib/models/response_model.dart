import 'dart:convert';

class ResponseModel {
  final bool isSuccess;
  final String message;
  ResponseModel({
    required this.isSuccess,
    required this.message,
  });

  ResponseModel copyWith({
    bool? isSuccess,
    String? message,
  }) {
    return ResponseModel(
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isSuccess': isSuccess,
      'message': message,
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      isSuccess: map['isSuccess'] as bool,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ResponseModel(isSuccess: $isSuccess, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResponseModel &&
        other.isSuccess == isSuccess &&
        other.message == message;
  }

  @override
  int get hashCode => isSuccess.hashCode ^ message.hashCode;
}
