import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_socialpulse/models/user.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment{
  int? id;
  String? text;
  int? userId;
  User? user;
  int? postId;

  Comment (this.id,this.text,this.userId,this.user,this.postId);

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}