import 'package:flutter/material.dart';

import 'base_model.dart';

class SelectOption implements BaseModel<SelectOption> {
  final String id;
  final String name;
  final Color color;
  final IconData? icon;

  SelectOption({
    required this.id,
    required this.name,
    this.color = Colors.grey,
    this.icon,
  });

  factory SelectOption.fromJson(Map<String, dynamic> json) {
    return SelectOption(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      color: Color(json['color'] ?? Colors.grey.toARGB32()),
      icon: json['icon'] != null ? IconData(json['icon'], fontFamily: 'MaterialIcons') : null,
    );
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SelectOption && other.id == id;
  }

  SelectOption copyWith({
    String? id,
    String? name,
    Color? color,
    IconData? icon,
  }) {
    return SelectOption(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
    );
  }

  @override
  SelectOption fromJson(Map<String, dynamic> json) => SelectOption.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color.toARGB32(),
      'icon': icon?.codePoint,
    };
  }

  @override
  String toString() => 'SelectOption(id: $id, name: $name)';
}
