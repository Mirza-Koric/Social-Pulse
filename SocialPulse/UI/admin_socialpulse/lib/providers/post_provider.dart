import '../models/post.dart';
import 'base_provider.dart';

class PostProvider extends BaseProvider<Post>{
  PostProvider():super('Posts');

  @override
  Post fromJson(data){
    return Post.fromJson(data);
  }
}