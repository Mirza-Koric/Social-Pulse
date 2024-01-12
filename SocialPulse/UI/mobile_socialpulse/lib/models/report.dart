import 'package:json_annotation/json_annotation.dart';

part 'report.g.dart';

@JsonSerializable()
class Report{
  int? id;
  String? reportReason;
  int? reporterId;
  int? reportedId;

  Report (this.id,this.reportReason,this.reporterId,this.reportedId);

  factory Report.fromJson(Map<String, dynamic> json) =>
      _$ReportFromJson(json);

  Map<String, dynamic> toJson() => _$ReportToJson(this);
}