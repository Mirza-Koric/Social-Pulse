import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_socialpulse/models/user_conversation.dart';

import 'message.dart';

part 'conversation.g.dart';

@JsonSerializable()
class Conversation{
  int? id;
  List<Message>? messages;
  List<UserConversation>? users;

  Conversation (this.id, this.messages, this.users);

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationToJson(this);
}