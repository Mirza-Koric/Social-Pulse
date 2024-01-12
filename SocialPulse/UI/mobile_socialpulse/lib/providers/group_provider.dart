import '../models/group.dart';
import 'base_provider.dart';

class GroupProvider extends BaseProvider<Group>{
  GroupProvider():super('Groups');

  @override
  Group fromJson(data){
    return Group.fromJson(data);
  }
}