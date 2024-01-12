import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_socialpulse/models/tag.dart';
import 'package:mobile_socialpulse/models/user.dart';

import 'comment.dart';
import 'group.dart';
import 'image.dart';
import 'like.dart';

part 'post.g.dart';

@JsonSerializable()
class Post{
  int? id;
  String? title;
  String? text;
  int? userId;
  User? user;
  int? groupId;
  Group? group;
  int? tagId;
  Tag? tag;

  Post (
      this.id,
      this.title,
      this.text,
      this.userId,
      this.user,
      this.groupId,
      this.group,
      this.tagId,
      this.tag,);

  factory Post.fromJson(Map<String, dynamic> json) =>
      _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}