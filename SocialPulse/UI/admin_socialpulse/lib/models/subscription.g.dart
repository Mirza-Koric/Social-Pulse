// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) => Subscription(
      json['id'] as int?,
      json['active'] as bool?,
      json['userId'] as int?,
      json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'userId': instance.userId,
      'expirationDate': instance.expirationDate?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };
