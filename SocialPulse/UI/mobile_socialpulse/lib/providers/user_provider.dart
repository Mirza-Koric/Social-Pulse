import 'dart:convert';

import 'package:http/http.dart';

import '../models/user.dart';
import 'base_provider.dart';

class UserProvider extends BaseProvider<User>{
  UserProvider():super('Users');

  @override
  User fromJson(data){
    return User.fromJson(data);
  }

  Future<dynamic> changePassword(dynamic object) async {
    var url = "${BaseProvider.baseUrl}$endpoint/ChangePassword";

    var uri = Uri.parse(url);

    var jsonRequest = jsonEncode(object);
    var headers = createHeaders();

    Response response = await put(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {

    } else {
      throw  Exception("Unknown error");
    }
  }
}