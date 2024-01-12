import '../models/answer.dart';
import 'base_provider.dart';

class AnswerProvider extends BaseProvider<Answer>{
  AnswerProvider():super('Answers');

  @override
  Answer fromJson(data){
    return Answer.fromJson(data);
  }
}