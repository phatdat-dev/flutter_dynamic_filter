import 'base_model.dart';

class User implements BaseModel<User> {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  final bool isCurrentUser;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    this.isCurrentUser = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'],
      isCurrentUser: json['isCurrentUser'] ?? false,
    );
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? avatar,
    bool? isCurrentUser,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      isCurrentUser: isCurrentUser ?? this.isCurrentUser,
    );
  }

  @override
  User fromJson(Map<String, dynamic> json) => User.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'isCurrentUser': isCurrentUser,
    };
  }

  @override
  String toString() => 'User(id: $id, name: $name, email: $email)';
}
