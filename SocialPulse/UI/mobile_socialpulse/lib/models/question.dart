import 'package:json_annotation/json_annotation.dart';

import 'answer.dart';

part 'question.g.dart';

@JsonSerializable()
class Question{
  int? id;
  String? text;
  int? userId;
  Answer? answer;

  Question (this.id,this.text,this.userId, this.answer);

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}