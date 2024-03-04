// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      json['id'] as int?,
      json['title'] as String?,
      json['text'] as String?,
      json['isAdvert'] as bool?,
      json['userId'] as int?,
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      json['groupId'] as int?,
      json['group'] == null
          ? null
          : Group.fromJson(json['group'] as Map<String, dynamic>),
      json['tagId'] as int?,
      json['tag'] == null
          ? null
          : Tag.fromJson(json['tag'] as Map<String, dynamic>),
      (json['likes'] as List<dynamic>?)
          ?.map((e) => Like.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['images'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'text': instance.text,
      'isAdvert': instance.isAdvert,
      'userId': instance.userId,
      'user': instance.user,
      'groupId': instance.groupId,
      'group': instance.group,
      'tagId': instance.tagId,
      'tag': instance.tag,
      'likes': instance.likes,
      'images': instance.images,
    };
