import '../models/subscription.dart';
import 'base_provider.dart';

class SubscriptionProvider extends BaseProvider<Subscription>{
  SubscriptionProvider():super('Subscriptions');

  @override
  Subscription fromJson(data){
    return Subscription.fromJson(data);
  }
}