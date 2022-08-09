import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp_nhat_2022/constants/constants.dart';
import 'package:myapp_nhat_2022/screens/transaction/transaction.dart';

import '../../../app/bloc/app_bloc.dart';
import '../../transfer/transfer.dart';

class DrawerMenubar extends StatelessWidget {
  late double withImageIcon = 30;
  late double sizeText = 22;
  late Color colorText = Colors.indigoAccent;
  late double withIconArrow = 25;

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    final CollectionReference profile =
        FirebaseFirestore.instance.collection(user.email!);
    return StreamBuilder<QuerySnapshot>(
        stream: profile.snapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
                width: 100,
                height: 100,
                child: Center(
                  child: CircularProgressIndicator(),
                ));
          }
          try {
            final DocumentSnapshot documentSnapshot = snapshot.data!.docs[0];
            return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 270,
                        margin: const EdgeInsets.only(top: 60, left: 20),
                        height: 100,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image.network(
                                'https://scontent.fhan5-8.fna.fbcdn.net/v/t1.6435-9/131616206_1020347125140235_8464868098794226663_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=yAIjl92yc-YAX8JiePY&_nc_ht=scontent.fhan5-8.fna&oh=00_AT_-exk3oJa0VMs8KnGAIEaZP0ah-LxT604hbqJpONdAKA&oe=6307C649',
                                width: 60.0,
                                height: 60.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${documentSnapshot['name']}".toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.primary),
                                ),
                                Text(
                                  '${user.email}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color:
                                          Colors.indigoAccent.withOpacity(0.8)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: SizedBox(
                              width: 270,
                              child: Row(
                                children: [
                                  Image.asset(
                                    MyIcons.iconPayments1,
                                    width: withImageIcon,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Chuyển khoản',
                                    style: TextStyle(
                                        fontSize: sizeText, color: colorText),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: withIconArrow,
                                    color: colorText,
                                  )
                                ],
                              ),
                            ),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const TransferPage(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            leading: SizedBox(
                              width: 270,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(MyIcons.iconPayments1_1,
                                      width: withImageIcon),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Giao dịch',
                                    style: TextStyle(
                                        fontSize: sizeText, color: colorText),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: withIconArrow,
                                    color: colorText,
                                  )
                                ],
                              ),
                            ),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const Transaction1(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            leading: SizedBox(
                              width: 270,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(MyIcons.iconMycards1,
                                      width: withImageIcon),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Thẻ của tôi',
                                    style: TextStyle(
                                        fontSize: sizeText, color: colorText),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: withIconArrow,
                                    color: colorText,
                                  )
                                ],
                              ),
                            ),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const Note(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            leading: SizedBox(
                              width: 270,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    MyIcons.iconPromotions1,
                                    width: withImageIcon,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Khuyến mãi',
                                    style: TextStyle(
                                        fontSize: sizeText, color: colorText),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: withIconArrow,
                                    color: colorText,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const Note(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            leading: SizedBox(
                              width: 270,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    MyIcons.iconPayments1_2,
                                    width: withImageIcon,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Tiết kiệm',
                                    style: TextStyle(
                                        fontSize: sizeText, color: colorText),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: withIconArrow,
                                    color: colorText,
                                  )
                                ],
                              ),
                            ),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const Note(),
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 0.4,
                          ),
                          ListTile(
                            leading: SizedBox(
                              width: 270,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    MyIcons.iconLogout1,
                                    width: withImageIcon,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Thoát',
                                    style: TextStyle(
                                        fontSize: sizeText, color: colorText),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: withIconArrow,
                                    color: colorText,
                                  )
                                ],
                              ),
                            ),
                            onTap: () => context
                                .read<AppBloc>()
                                .add(AppLogoutRequested()),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            );
          } catch (e) {
            return Container();
          }
        });
  }
}

class Note extends StatelessWidget {
  const Note({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('‘Note’'),
      ),
      body: const Center(
        child: Icon(
          Icons.note_add,
          size: 120.0,
          color: Colors.orange,
        ),
      ),
    );
  }
}

class Mood extends StatelessWidget {
  const Mood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('‘Mood’'),
      ),
      body: const Center(
        child: Icon(
          Icons.mood,
          size: 120.0,
          color: Colors.orange,
        ),
      ),
    );
  }
}

class Promotions extends StatelessWidget {
  const Promotions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promotions'),
      ),
      body: const Center(
        child: Icon(
          Icons.date_range,
          size: 120.0,
          color: Colors.orange,
        ),
      ),
    );
  }
}
