// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserConversation _$UserConversationFromJson(Map<String, dynamic> json) =>
    UserConversation(
      json['id'] as int?,
      json['userId'] as int?,
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      json['conversationId'] as int?,
      json['conversation'] == null
          ? null
          : Conversation.fromJson(json['conversation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserConversationToJson(UserConversation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'user': instance.user,
      'conversationId': instance.conversationId,
      'conversation': instance.conversation,
    };
