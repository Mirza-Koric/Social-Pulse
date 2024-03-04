import '../models/report.dart';
import 'base_provider.dart';

class ReportProvider extends BaseProvider<Report>{
  ReportProvider():super('Reports');

  @override
  Report fromJson(data){
    return Report.fromJson(data);
  }
}