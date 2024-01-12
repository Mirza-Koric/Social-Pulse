// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserConversation _$UserConversationFromJson(Map<String, dynamic> json) =>
    UserConversation(
      json['id'] as int?,
      json['userId'] as int?,
      json['conversationId'] as int?,
    );

Map<String, dynamic> _$UserConversationToJson(UserConversation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'conversationId': instance.conversationId,
    };
