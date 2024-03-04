// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      json['id'] as int?,
      json['reportReason'] as String?,
      json['reporterId'] as int?,
      json['reportedId'] as int?,
    );

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'id': instance.id,
      'reportReason': instance.reportReason,
      'reporterId': instance.reporterId,
      'reportedId': instance.reportedId,
    };
