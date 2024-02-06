// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      json['id'] as int?,
      json['text'] as String?,
      json['userId'] as int?,
      json['answer'] == null
          ? null
          : Answer.fromJson(json['answer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'userId': instance.userId,
      'answer': instance.answer,
    };
