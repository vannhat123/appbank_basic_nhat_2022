import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp_nhat_2022/constants/constants.dart';
import '../../app/bloc/app_bloc.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _nameController = TextEditingController();
  final _textNameController = TextEditingController();
  final _textAddressController = TextEditingController();
  final _textAgeController = TextEditingController();
  final _textPhoneController = TextEditingController();
  final random = Random();
  late int valueRandom = random.nextInt(1000);

  Future<void> _update(
      DocumentSnapshot? documentSnapshot, var valueConfig, var email) async {
    _nameController.text = documentSnapshot![valueConfig];
    final CollectionReference profileUpdate =
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
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelStyle:
                      const TextStyle(color: Colors.white, fontSize: 18),
                      labelText: valueConfig,
                      enabledBorder: const OutlineInputBorder(
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
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered))
                              return Colors.green;
                            return Colors
                                .indigoAccent; // Use the component's default.
                          },
                        ),
                      ),
                      child: const Text("Thay đổi"),
                      onPressed: () async {
                        final String? name = _nameController.text;
                        if (name != null) {
                          await profileUpdate
                              .doc(documentSnapshot.id)
                              .update({valueConfig: name});
                          _nameController.text = '';
                          // Hide the bottom sheet
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

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
    return SafeArea(
        child: Container(
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
              final DocumentSnapshot documentSnapshot = snapshot.data!.docs[0];
              final data = snapshot.requireData;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
                    Column(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image.asset(
                                  "assets/images/131616206_1020347125140235_8464868098794226663_n.jpg",
                                  width: 70.0,
                                  height: 70.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 11),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${data.docs[0]["name"]}',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.indigoAccent,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      'Online',
                                      style: TextStyle(
                                          color: Colors.indigoAccent,
                                          fontSize: 18),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                          height: getHeight(400),
                          child: Column(
                            children: [
                              formProfile("Tên", "${data.docs[0]["name"]}",
                                  documentSnapshot, "name", user.email),
                              const Divider(
                                color: Colors.grey,
                                thickness: 0.4,
                              ),
                              formProfile(
                                  "Địa chỉ",
                                  "${data.docs[0]["address"]}",
                                  documentSnapshot,
                                  "address",
                                  user.email),
                              const Divider(
                                color: Colors.grey,
                                thickness: 0.4,
                              ),
                              formProfile("Tuổi", "${data.docs[0]["age"]}",
                                  documentSnapshot, "age", user.email),
                              const Divider(
                                color: Colors.grey,
                                thickness: 0.4,
                              ),
                              formProfile(
                                  "Điện thoại",
                                  "${data.docs[0]["phone"]}",
                                  documentSnapshot,
                                  "phone",
                                  user.email),
                              const Divider(
                                color: Colors.grey,
                                thickness: 0.4,
                              ),
                            ],
                          )),
                      _ButtonLogout(
                        text: 'Thoát',
                        press: () =>
                            context.read<AppBloc>().add(AppLogoutRequested()),
                        colorButtonText: Colors.indigoAccent,
                        colorBackGroundButton: Colors.white,
                      ),
                    ])
                  ],
                ),
              );
            } catch (e) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  const Text("Vui lòng nhập \n thông tin cá nhân",textAlign: TextAlign.center,style: TextStyle(
                    color: MyColors.primary, fontSize: 27,fontWeight: FontWeight.bold
                  ),),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.green;
                          }
                          return MyColors.primary; // Use the component's default.
                        },
                      ),
                    ),
                    onPressed: () {
                      _add( user.email);
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
    ));
  }

  Row formProfile(String name, String valueName,
      DocumentSnapshot? documentSnapshot, var valueConfig, var email) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10, bottom: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                valueName,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.indigoAccent,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
        IconButton(
            onPressed: () => _update(documentSnapshot, valueConfig, email),
            icon: const Icon(
              Icons.edit,
              size: 20,
              color: Colors.indigoAccent,
            ))
      ],
    );
  }
}

class _ButtonLogout extends StatelessWidget {
  const _ButtonLogout({
    Key? key,
    this.text,
    this.press,
    this.colorButtonText,
    this.colorBackGroundButton,
  }) : super(key: key);
  final String? text;
  final Function? press;
  final Color? colorButtonText;
  final Color? colorBackGroundButton;
  static const IconData arrow_forward =
      IconData(0xe09b, fontFamily: 'MaterialIcons', matchTextDirection: true);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 70,
        child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              primary: Colors.black,
              backgroundColor: colorBackGroundButton!,
              side: const BorderSide(color: Colors.indigoAccent),
            ),
            onPressed: press as void Function()?,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Text(
                    text!,
                    style: TextStyle(
                        color: colorButtonText!,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ))));
  }
}

class _ButtonAdd extends StatelessWidget {
  const _ButtonAdd({
    Key? key,
    this.text,
    this.press,
    this.colorButtonText,
    this.colorBackGroundButton,
  }) : super(key: key);
  final String? text;
  final Function? press;
  final Color? colorButtonText;
  final Color? colorBackGroundButton;
  static const IconData arrow_forward =
      IconData(0xe09b, fontFamily: 'MaterialIcons', matchTextDirection: true);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 70,
        child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              primary: Colors.black,
              backgroundColor: colorBackGroundButton!,
              side: const BorderSide(color: Colors.indigoAccent),
            ),
            onPressed: press as void Function()?,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Text(
                    text!,
                    style: TextStyle(
                        color: colorButtonText!,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ))));
  }
}
