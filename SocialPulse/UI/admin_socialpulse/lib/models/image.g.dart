// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Image _$ImageFromJson(Map<String, dynamic> json) => Image(
      json['id'] as int?,
      json['data'] as String?,
      json['contentType'] as String?,
      json['postId'] as int?,
      json['messageId'] as int?,
    );

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'id': instance.id,
      'data': instance.data,
      'contentType': instance.contentType,
      'postId': instance.postId,
      'messageId': instance.messageId,
    };
