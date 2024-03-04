import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable()
class Image{
  int? id;
  String? data;
  String? contentType;
  int? postId;
  int? messageId;

  Image (this.id,this.data,this.contentType,this.postId,this.messageId);

  factory Image.fromJson(Map<String, dynamic> json) =>
      _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}