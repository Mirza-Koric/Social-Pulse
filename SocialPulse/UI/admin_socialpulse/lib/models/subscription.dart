import 'package:json_annotation/json_annotation.dart';

part 'subscription.g.dart';

@JsonSerializable()
class Subscription {
  int? id;
  bool? active;
  int? userId;
  DateTime? expirationDate;
  DateTime? createdAt;

  Subscription(
      this.id, this.active, this.userId, this.expirationDate, this.createdAt);

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);
}
