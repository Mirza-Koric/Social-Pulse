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
  bool? isAdvert;
  int? userId;
  User? user;
  int? groupId;
  Group? group;
  int? tagId;
  Tag? tag;
  List<Comment>? comments;
  List<Like>? likes;
  List<Image>? images;

  Post (
      this.id,
      this.title,
      this.text,
      this.isAdvert,
      this.userId,
      this.user,
      this.groupId,
      this.group,
      this.tagId,
      this.tag,
      this.comments,
      this.likes,
      this.images);

  factory Post.fromJson(Map<String, dynamic> json) =>
      _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}