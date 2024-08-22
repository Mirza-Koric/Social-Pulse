import 'dart:convert';

import 'package:admin_socialpulse/models/notification.dart';
import 'package:admin_socialpulse/providers/base_provider.dart';
import 'package:admin_socialpulse/utils/utils.dart';
import 'package:http/http.dart';

class NotificationProvider extends BaseProvider<Notif> {
  String? _mainBaseUrl;
  final String _mainEndpoint = "api/Notification/SendNotification";

  NotificationProvider() : super('Notifications') {
    _mainBaseUrl = const String.fromEnvironment("mainBaseUrl",
        defaultValue: "http://localhost:7198/");
  }

  @override
  Notif fromJson(data) {
    return Notif.fromJson(data);
  }

  Future<dynamic> sendRabbitNotification(dynamic object) async {
    var url = "$_mainBaseUrl$_mainEndpoint";

    var uri = Uri.parse(url);
    var jsonRequest = jsonEncode(object);

    String jwt = Authentification.token ?? '';

    String jwtAuth = "Bearer $jwt";
    var headers = {
      "Content-Type": "application/json",
      "Authorization": jwtAuth
    };

    Response response = await post(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      throw Exception("Unknown error");
    }
  }
}
