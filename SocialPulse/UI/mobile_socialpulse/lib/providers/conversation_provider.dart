import '../models/conversation.dart';
import 'base_provider.dart';

class ConversationProvider extends BaseProvider<Conversation>{
  ConversationProvider():super('Conversations');

  @override
  Conversation fromJson(data){
    return Conversation.fromJson(data);
  }
}