import 'package:json_annotation/json_annotation.dart';

part 'recommend_result.g.dart';

@JsonSerializable()
class RecommendResult {
  int? id;
  int? postId;
  int? firstCopostId;
  int? secondCopostId;
  int? thirdCopostId;

  RecommendResult(this.id, this.postId, this.firstCopostId, this.secondCopostId, this.thirdCopostId);

  factory RecommendResult.fromJson(Map<String, dynamic> json) =>
      _$RecommendResultFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendResultToJson(this);
}