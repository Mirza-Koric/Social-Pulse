import 'dart:convert';

import 'package:http/http.dart';
import 'package:mobile_socialpulse/models/search_result.dart';

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

  Future<SearchResult<Post>> getRandom({dynamic filter}) async {
    var url = "${BaseProvider.baseUrl}$endpoint/GetRandom";

    if (filter != null) {
      var querryString = getQueryString(filter);
      url = "$url?$querryString";
    }

    var uri = Uri.parse(url);
    var headers = createHeaders();

    Response response = await get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      var result = SearchResult<Post>();
      result.hasNextPage = data['hasNextPage'];
      result.hasPreviousPage = data['hasPreviousPage'];
      result.isFirstPage = data['isFirstPage'];
      result.isLastPage = data['isLastPage'];
      result.pageCount = data['pageCount'];
      result.pageNumber = data['pageNumber'];
      result.pageSize = data['pageSize'];
      result.totalCount = data['totalCount'];

      for (var a in data['items']) {
        result.items.add(fromJson(a));
      }

      return result;
    } else {
      throw Exception("Unknown error");
    }
  }
}