import 'package:flutter/material.dart';

class ItemMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Center(
          child: Text(" Item Menu", style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
        )
    );
  }
}
