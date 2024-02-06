import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_socialpulse/models/user.dart';

import 'conversation.dart';

part 'user_conversation.g.dart';

@JsonSerializable()
class UserConversation{
  int? id;
  int? userId;
  User? user;
  int? conversationId;
  Conversation? conversation;

  UserConversation (this.id,this.userId,this.user,this.conversationId,this.conversation);

  factory UserConversation.fromJson(Map<String, dynamic> json) =>
      _$UserConversationFromJson(json);

  Map<String, dynamic> toJson() => _$UserConversationToJson(this);
}