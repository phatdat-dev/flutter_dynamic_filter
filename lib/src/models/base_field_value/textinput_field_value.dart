import '../base_field.dart';

class TextInputFieldValue implements BaseFieldValue<TextInputFieldValue> {
  final String value;

  TextInputFieldValue({
    required this.value,
  });

  factory TextInputFieldValue.fromJson(Map<String, dynamic> json) => TextInputFieldValue(
        value: json["value"],
      );

  @override
  TextInputFieldValue fromJson(Map<String, dynamic> json) => TextInputFieldValue.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["value"] = value;
    return data;
  }

  // copyWith
  TextInputFieldValue copyWith({
    String? value,
  }) {
    return TextInputFieldValue(
      value: value ?? this.value,
    );
  }
}
