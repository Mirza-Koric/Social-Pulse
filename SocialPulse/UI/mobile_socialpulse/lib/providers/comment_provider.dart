import '../models/comment.dart';
import 'base_provider.dart';

class CommentProvider extends BaseProvider<Comment>{
  CommentProvider():super('Comments');

  @override
  Comment fromJson(data){
    return Comment.fromJson(data);
  }
}