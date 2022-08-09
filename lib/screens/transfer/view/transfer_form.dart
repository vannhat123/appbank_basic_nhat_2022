import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp_nhat_2022/screens/app_tab/app_tap.dart';
import '../../../app/bloc/app_bloc.dart';
import '../../../constants/colors.dart';
import '../../../constants/icons.dart';
import '../../../constants/images.dart';
import '../../../constants/screen_sizes.dart';
import '../../widgets/header.dart';

class TransferForm extends StatefulWidget {
  const TransferForm({Key? key}) : super(key: key);

  @override
  _TransferFormState createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  final _formKey = GlobalKey<FormState>();
  final _txtMoneyController = TextEditingController();
  final _txtAccountController = TextEditingController();
  String money = "";
  String account = '';

  @override
  void initState() {
    super.initState();
    _txtAccountController.text = account;
    _txtMoneyController.text = money;
  }

  @override
  void dispose() {
    super.dispose();
    _txtAccountController.dispose();
    _txtMoneyController.dispose();
  }

  Future<void> _submitFormOnTransfer(
      DocumentSnapshot? documentSnapshot, var yourEmail) async {
    final CollectionReference _yourProfile =
        FirebaseFirestore.instance.collection(yourEmail);

    int yourBalance =
        (documentSnapshot!["balance"]) - int.parse(_txtMoneyController.text);
    await _yourProfile.doc(yourEmail).update({"balance": yourBalance});
  }

  Future<void> _showSucess() async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          final CollectionReference _profile =
              FirebaseFirestore.instance.collection(_txtAccountController.text);
          return StreamBuilder<QuerySnapshot>(
              stream: _profile.snapshots(),
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
                final DocumentSnapshot documentSnapshot =
                    snapshot.data!.docs[0];
                return Container(
                    height: getHeight(300),
                    color: MyColors.primary,
                    child: Center(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.green;
                              }
                              return MyColors
                                  .white; // Use the component's default.
                            },
                          ),
                        ),
                        onPressed: () async {
                          int add = (documentSnapshot["balance"]) +
                              int.parse(_txtMoneyController.text);
                          await _profile
                              .doc(_txtAccountController.text)
                              .update({"balance": add});
                           Navigator.push(context, MaterialPageRoute(builder:(_) => AppTab()));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            "Xác nhận",
                            style: TextStyle(
                                color: Colors.indigoAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ),
                    ));
              });
        });
  }
   Future<void> _errorMoney(var moneyCurrent) async {
    String errorText ='So du khong du';
     await showModalBottomSheet(
         isScrollControlled: true,
         context: context,
         builder: (BuildContext ctx) {
           return Container(
               height: getHeight(300),
               color: MyColors.primary,
               child: Center(
                 child: ElevatedButton(
                     style: ButtonStyle(
                       backgroundColor:
                       MaterialStateProperty.resolveWith<Color>(
                             (Set<MaterialState> states) {
                           if (states.contains(MaterialState.hovered)) {
                             return Colors.green;
                           }
                           return MyColors
                               .white; // Use the component's default.
                         },
                       ),
                     ),
                     onPressed: () async {
                         if(moneyCurrent < int.parse(_txtMoneyController.text)){
                           errorText = "Số dư không đủ";
                       }
                      Navigator.of(context).pop();
                     },
                     child: Container(
                       padding: const EdgeInsets.all(10),
                       child:  Text(
                         errorText,
                         style: const TextStyle(
                             color: Colors.indigoAccent,
                             fontSize: 20,
                             fontWeight: FontWeight.bold),
                       ),
                     )
                 ),
               ));
         }
     );
   }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    final CollectionReference profile =
        FirebaseFirestore.instance.collection(user.email!);
    return Scaffold(
      backgroundColor: MyColors.primary,
      body: Form(
          key: _formKey,
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
              DocumentSnapshot documentSnapshot = snapshot.data!.docs[0];
              return SafeArea(
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              Header(
                                leftIcon: MyIcons.back,
                                onPressLeftIcon: () {
                                  Navigator.pop(context);
                                },
                                rightIcon: MyIcons.menu,
                                onPressRightIcon: () => null,
                                title: "Chuyển khoản",
                              ),
                              SizedBox(
                                height: getHeight(200),
                                child: Center(
                                  child: Image.asset(
                                    MyImages.logowhite,
                                    scale: getWidth(0.9),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Số dư: ${documentSnapshot["balance"]}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(height: 8),
                                  buildMoneyFormField(),
                                  const SizedBox(height: 13),
                                  buildAccountFormField(),
                                  const SizedBox(height: 13),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.hovered)) {
                                              return Colors.green;
                                            }
                                            return Colors
                                                .white; // Use the component's default.
                                          },
                                        ),
                                      ),
                                      onPressed: () {
                                        if(documentSnapshot["balance"] > int.parse(_txtMoneyController.text)){
                                          _submitFormOnTransfer( documentSnapshot, user.email);
                                          _showSucess();
                                        } else{
                                          _errorMoney(documentSnapshot["balance"]);
                                          }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        child: const Text(
                                          "Chuyển ngay",
                                          style: TextStyle(
                                              color: Colors.indigoAccent,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )));
            },
          )),
    );
  }

  TextFormField buildMoneyFormField() {
    return TextFormField(
      controller: _txtMoneyController,
      style: const TextStyle(color: Colors.white, fontSize: 20),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onSaved: (newValue) => money = newValue!,
      decoration: const InputDecoration(
        labelText: "Số tiền",
        labelStyle: TextStyle(color: Colors.white),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  TextFormField buildAccountFormField() {
    return TextFormField(
      controller: _txtAccountController,
      style: const TextStyle(color: Colors.white, fontSize: 20),
      keyboardType: TextInputType.text,
      onSaved: (newValue) => account = newValue!,
      decoration: const InputDecoration(
        labelText: "Email người nhận",
        labelStyle: TextStyle(color: Colors.white),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
