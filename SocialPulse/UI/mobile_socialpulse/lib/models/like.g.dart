// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Like _$LikeFromJson(Map<String, dynamic> json) => Like(
      json['id'] as int?,
      json['type'] as bool?,
      json['postId'] as int?,
      json['userId'] as int?,
    );

Map<String, dynamic> _$LikeToJson(Like instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'postId': instance.postId,
      'userId': instance.userId,
    };
