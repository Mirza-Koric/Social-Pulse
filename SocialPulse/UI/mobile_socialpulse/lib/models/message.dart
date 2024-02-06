
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_socialpulse/models/image.dart';

part 'message.g.dart';

@JsonSerializable()
class Message{
  int? id;
  String? text;
  int? userId;
  int? conversationId;
  DateTime? createdAt;
  List<Image>? images;

  Message (this.id,this.text,this.userId,this.conversationId, this.createdAt, this.images);

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}