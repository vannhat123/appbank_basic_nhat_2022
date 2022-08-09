import 'package:flutter/material.dart';
import 'package:myapp_nhat_2022/screens/home/home.dart';
import 'package:myapp_nhat_2022/screens/notification/notification.dart';
import 'package:myapp_nhat_2022/screens/profile/profile.dart';

import '../../../constants/constants.dart';

//Bloc = Redux Saga(React)
class AppTab extends StatefulWidget {
  const AppTab({Key? key}) : super(key: key);

  static Page page()=> const MaterialPage<void>(child: AppTab());

  @override
  _AppTabState createState() => _AppTabState();
}

class _AppTabState extends State<AppTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  final List<Map<String, dynamic>> _tabs = [
    {
      'text': 'Trang chủ',
      'icon':  Image.asset(MyImages.profile,width: 20, color: Colors.white,),
      'screen': Home(),
    },
    {
      'text': 'Thông báo',
      'icon': Image.asset(MyImages.notification,width: 20, color: Colors.white,),
      'screen': Notification1(),
    },
    {
      'text': 'Cá nhân',
      'icon': Image.asset(MyImages.profile,width: 20, color: Colors.white,),
      'screen':  Profile(),
    }
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: MyColors.primary,
          child: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: const EdgeInsets.all(5.0),
            indicatorColor: Colors.white,
            tabs: _tabs.map((eachTab) => Tab(
                text: eachTab['text'],
                icon: eachTab['icon']
            )).toList(),
          ),
        ),
        body: TabBarView(
          children: _tabs.map((eachTab) => eachTab['screen'] as Widget).toList(),
        ),
      ),
    );
  }
}
