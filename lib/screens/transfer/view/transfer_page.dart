import 'package:flutter/material.dart';
import 'package:myapp_nhat_2022/screens/transfer/transfer.dart';

class TransferPage extends StatelessWidget {
  const TransferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  TransferForm(),
    );
  }
}
