import 'package:flutter/cupertino.dart';
import 'package:myapp_nhat_2022/repositories/user_repository.dart';
import 'package:myapp_nhat_2022/screens/profileconfig/profile_config.dart';


final Map<String, WidgetBuilder> routes = {
  UserRepos.routeName: (context) => UserRepos(),
};
