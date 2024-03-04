import '../models/image.dart';
import 'base_provider.dart';

class MyImageProvider extends BaseProvider<Image>{
  MyImageProvider():super('Images');

  @override
  Image fromJson(data){
    return Image.fromJson(data);
  }
}