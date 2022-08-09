import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp_nhat_2022/constants/constants.dart';
import 'package:myapp_nhat_2022/screens/home/components/drawer_menubar.dart';
import 'package:myapp_nhat_2022/screens/transaction/transaction.dart';

import '../../app/bloc/app_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _textNameController = TextEditingController();
  final _textAddressController = TextEditingController();
  final _textAgeController = TextEditingController();
  final _textPhoneController = TextEditingController();
  final random = Random();
  late int valueRandom = random.nextInt(1000);

  Future<void> _add(var email) async {
    final CollectionReference profileAdd =
        FirebaseFirestore.instance.collection(email);
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Container(
              color: MyColors.primary,
              child: Padding(
                padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      controller: _textNameController,
                      decoration: const InputDecoration(
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 20),
                        labelText: "name",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      controller: _textAgeController,
                      decoration: const InputDecoration(
                        labelText: "age",
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 20),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      controller: _textAddressController,
                      decoration: const InputDecoration(
                        labelText: "address",
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 20),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      controller: _textPhoneController,
                      decoration: const InputDecoration(
                        labelText: "phone",
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 20),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.green;
                              }
                              return Colors
                                  .white; // Use the component's default.
                            },
                          ),
                        ),
                        child: const Text(
                          "Tạo",
                          style:
                              TextStyle(color: MyColors.primary, fontSize: 20),
                        ),
                        onPressed: () async {
                          final String name = _textNameController.text;
                          final String age = _textAgeController.text;
                          final String address = _textAddressController.text;
                          final String phone = _textPhoneController.text;

                          if (name != null &&
                              phone != null &&
                              address != null &&
                              age != null) {
                            await profileAdd.doc(email).set({
                              'name': name,
                              'age': age,
                              'address': address,
                              'phone': phone,
                              'account': "1255${valueRandom.toString()}",
                              'email': email,
                              'balance': 0
                            });
                            _textNameController.text = '';
                            _textAgeController.text = '';
                            _textAddressController.text = '';
                            _textPhoneController.text = '';
                            // Hide the bottom sheet
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    )
                  ],
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    final CollectionReference profile =
        FirebaseFirestore.instance.collection(user.email!);
    return Scaffold(
      appBar: AppBar(
          shadowColor: Colors.white12,
          backgroundColor: MyColors.primary,
          title: Row(
            children: [
              const Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.network(
                  'https://scontent.fhan5-8.fna.fbcdn.net/v/t1.6435-9/131616206_1020347125140235_8464868098794226663_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=yAIjl92yc-YAX8JiePY&_nc_ht=scontent.fhan5-8.fna&oh=00_AT_-exk3oJa0VMs8KnGAIEaZP0ah-LxT604hbqJpONdAKA&oe=6307C649',
                  width: 40.0,
                  height: 40.0,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: StreamBuilder<QuerySnapshot>(
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
                final DocumentSnapshot documentSnapshot =
                    snapshot.data!.docs[0];
                return Container(
                  color: Colors.indigoAccent,
                  child: ListView(
                    children: [
                      Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          child: Column(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Text(
                                    '${user.email}',
                                    style: const TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 25,
                                        color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: getHeight(20)),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 20),
                                  height: getHeight(300),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white10,
                                        blurRadius: 10.0,
                                        spreadRadius: 5.0,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Account: ${documentSnapshot['account']}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: MyColors.primary
                                                    .withOpacity(0.8)),
                                          ),
                                          const Spacer(),
                                          Image.asset(
                                            'assets/images/More 1.png',
                                            color: MyColors.primary,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "Balance: ${documentSnapshot['balance']}\$",
                                        style: const TextStyle(
                                            fontSize: 30,
                                            color: Colors.indigoAccent,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        height: getHeight(150),
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          'assets/images/Columns.png',
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: getHeight(30)),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 20),
                              height: getHeight(140),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white10,
                                    blurRadius: 10.0,
                                    spreadRadius: 5.0,
                                  ),
                                ],
                              ),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Check your\n Bank Account',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.indigoAccent),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                        child: const Align(
                                          child: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.indigoAccent,
                                          ),
                                        ),
                                        onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const Transaction1()),
                                            )),
                                  ]),
                            ),
                          ])),
                    ],
                  ),
                );
              } catch (e) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Vui lòng nhập \n thông tin cá nhân",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.primary,
                            fontSize: 27,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.green;
                              }
                              return MyColors
                                  .primary; // Use the component's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          _add(user.email);
                        },
                        child: const Text(
                          "Tạo mới",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.green;
                              }
                              return MyColors.primary.withOpacity(
                                  0.5); // Use the component's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          context.read<AppBloc>().add(AppLogoutRequested());
                        },
                        child: const Text(
                          "Thoát",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    ]);
              }
            }),
      ),
      drawer: DrawerMenubar(),
    );
  }
}
