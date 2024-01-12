import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message{
  int? id;
  String? text;
  int? userId;
  int? conversationId;

  Message (this.id,this.text,this.userId,this.conversationId);

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}