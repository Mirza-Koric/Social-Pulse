import 'package:json_annotation/json_annotation.dart';

part 'answer.g.dart';

@JsonSerializable()
class Answer{
  int? id;
  String? text;
  int? adminId;
  int? questionId;

  Answer (this.id,this.text,this.questionId,this.adminId);

  factory Answer.fromJson(Map<String, dynamic> json) =>
      _$AnswerFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerToJson(this);
}