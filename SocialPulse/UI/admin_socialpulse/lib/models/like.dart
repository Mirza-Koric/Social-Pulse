import 'package:json_annotation/json_annotation.dart';

part 'like.g.dart';

@JsonSerializable()
class Like{
  int? id;
  bool? type;
  int? postId;
  int? userId;

  Like (this.id,this.type,this.postId,this.userId);

  factory Like.fromJson(Map<String, dynamic> json) =>
      _$LikeFromJson(json);

  Map<String, dynamic> toJson() => _$LikeToJson(this);
}