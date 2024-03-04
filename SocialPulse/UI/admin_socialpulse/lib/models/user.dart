import 'package:json_annotation/json_annotation.dart';
import 'package:admin_socialpulse/models/subscription.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;
  String? username;
  String? email;
  String? role;
  DateTime? birthDate;
  Subscription? subscription;

  User(this.id, this.username, this.email, this.role, this.birthDate,
      this.subscription);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
