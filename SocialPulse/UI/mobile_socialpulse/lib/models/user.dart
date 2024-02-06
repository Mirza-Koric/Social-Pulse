import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User{
  int? id;
  String? username;
  String? email;
  String? role;
  DateTime? birthDate;

  User (this.id,this.username,this.email,this.role,this.birthDate);

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}