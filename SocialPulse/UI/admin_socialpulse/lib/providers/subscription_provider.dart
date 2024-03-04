import 'package:http/http.dart';

import '../models/subscription.dart';
import 'base_provider.dart';

class SubscriptionProvider extends BaseProvider<Subscription>{
  SubscriptionProvider():super('Subscriptions');

  @override
  Subscription fromJson(data){
    return Subscription.fromJson(data);
  }

  Future paySubscription(int id) async {
    var url = "${BaseProvider.baseUrl}$endpoint/PaySubscription?userId=$id";

    var uri = Uri.parse(url);

    var headers = createHeaders();

    Response response = await put(uri, headers: headers, body: null);

    if (isValidResponse(response)) {

    } else {
      throw Exception("Unknown error");
    }
  }
}