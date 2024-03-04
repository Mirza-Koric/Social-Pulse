import 'package:http/http.dart';

import '../models/post.dart';
import 'base_provider.dart';

class PostProvider extends BaseProvider<Post>{
  PostProvider():super('Posts');

  @override
  Post fromJson(data){
    return Post.fromJson(data);
  }

  Future<bool> exists(int postId) async {
    var url = "${BaseProvider.baseUrl}$endpoint/Exists/$postId";

    var uri = Uri.parse(url);

    var headers = createHeaders();

    Response response = await get(
      uri,
      headers: headers,
    );

    if (isValidResponse(response)) {
      bool so = response.body == "true" ? true : false;
      return so;
    } else {
      throw Exception("Unknown error");
    }
  }
}