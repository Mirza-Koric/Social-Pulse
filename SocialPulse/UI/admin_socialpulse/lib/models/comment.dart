import 'package:admin_socialpulse/models/post.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:admin_socialpulse/models/user.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  int? id;
  String? text;
  int? userId;
  User? user;
  int? postId;
  Post? post;

  Comment(this.id, this.text, this.userId, this.user, this.postId, this.post);

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
