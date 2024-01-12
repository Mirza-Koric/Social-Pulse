import '../models/message.dart';
import 'base_provider.dart';

class MessageProvider extends BaseProvider<Message>{
  MessageProvider():super('Messages');

  @override
  Message fromJson(data){
    return Message.fromJson(data);
  }
}