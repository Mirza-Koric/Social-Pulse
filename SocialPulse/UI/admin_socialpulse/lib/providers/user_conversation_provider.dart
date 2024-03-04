import '../models/user_conversation.dart';
import 'base_provider.dart';

class UserConversationProvider extends BaseProvider<UserConversation>{
  UserConversationProvider():super('UserConversations');

  @override
  UserConversation fromJson(data){
    return UserConversation.fromJson(data);
  }
}