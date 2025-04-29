class UserModel {
  final String? id;
  final String email;
  final String? name;

  UserModel({this.id, required this.email, this.name});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      email: json['email'] as String,
      name: json['name'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'name': name};
  }

  @override
  String toString() {
    return 'UserModel{id: $id, email: $email, name: $name}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.email == email &&
        other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ email.hashCode ^ name.hashCode;
  }

  UserModel copyWith({String? id, String? email, String? name}) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }
}
