import '../models/like.dart';
import 'base_provider.dart';

class LikeProvider extends BaseProvider<Like>{
  LikeProvider():super('Likes');

  @override
  Like fromJson(data){
    return Like.fromJson(data);
  }
}