import '../models/tag.dart';
import 'base_provider.dart';

class TagProvider extends BaseProvider<Tag>{
  TagProvider():super('Tags');

  @override
  Tag fromJson(data){
    return Tag.fromJson(data);
  }
}