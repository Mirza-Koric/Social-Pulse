// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommend_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendResult _$RecommendResultFromJson(Map<String, dynamic> json) =>
    RecommendResult(
      json['id'] as int?,
      json['postId'] as int?,
      json['firstCopostId'] as int?,
      json['secondCopostId'] as int?,
      json['thirdCopostId'] as int?,
    );

Map<String, dynamic> _$RecommendResultToJson(RecommendResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'firstCopostId': instance.firstCopostId,
      'secondCopostId': instance.secondCopostId,
      'thirdCopostId': instance.thirdCopostId,
    };
