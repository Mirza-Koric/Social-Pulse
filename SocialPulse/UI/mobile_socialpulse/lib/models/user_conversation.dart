import 'package:json_annotation/json_annotation.dart';

part 'user_conversation.g.dart';

@JsonSerializable()
class UserConversation{
  int? id;
  int? userId;
  int? conversationId;

  UserConversation (this.id,this.userId,this.conversationId);

  factory UserConversation.fromJson(Map<String, dynamic> json) =>
      _$UserConversationFromJson(json);

  Map<String, dynamic> toJson() => _$UserConversationToJson(this);
}