import 'dart:convert';

class Distance {
  final String text;
  final double value;

  Distance({
    required this.text,
    required this.value,
  });

  Distance copyWith({
    String? text,
    double? value,
  }) {
    return Distance(
      text: text ?? this.text,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'value': value,
    };
  }

  factory Distance.fromMap(Map<String, dynamic> map) {
    return Distance(
      text: map['text'] as String,
      value: map['value'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Distance.fromJson(String source) =>
      Distance.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Distance(text: $text, value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Distance && other.text == text && other.value == value;
  }

  @override
  int get hashCode => text.hashCode ^ value.hashCode;
}
