import 'package:flutter/material.dart';
import 'package:myapp_nhat_2022/constants/constants.dart';

import 'components/bottom_drawer_navigation.dart';

class Transaction1 extends StatelessWidget {
  const Transaction1({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(60)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.lightBlueAccent,
                          offset: Offset.zero,
                          blurRadius: 0,
                          spreadRadius: 4,
                        ),
                      ]),
                  height: getHeight(220),
                  width: double.infinity,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Column(children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 23,
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            const Spacer(),
                            const Text(
                              'Transactions',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const Spacer(),
                            const SizedBox(
                              width: 1,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Your total expences',
                          style: TextStyle(color: Colors.white54, fontSize: 25),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          '\$1063.30',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ]),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Track your expenses',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ContainerInformation(
                          textName: 'Travel',
                          textPrice: '\$399',
                          colorFont: Colors.pink,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ContainerInformation(
                          textName: 'Shopping',
                          textPrice: '\$375',
                          colorFont: Colors.amber,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ContainerInformation(
                          textName: 'Sport',
                          textPrice: '\$199.80',
                          colorFont: Colors.cyan,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ContainerInformation(
                          textName: 'Medicine',
                          textPrice: '\$89.8',
                          colorFont: Colors.deepPurple,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      width: MediaQuery.of(context).size.width * 0.88,
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.indigoAccent,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: const [
                          Text(
                            'Credit Card\n repayment',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 25,
                            color: Colors.white,
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomDrawerNavigation(),
    );
  }

  Widget searchField(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.white54, fontSize: 20),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white54,
            size: 25,
          ),
        ),
      ),
    );
  }
}

class ContainerInformation extends StatelessWidget {
  double sizeFont = 22;
  Color? colorFont;
  String? textName;
  String? textPrice;
  bool isHovering = false;

  ContainerInformation(
      {this.colorFont, this.textPrice, this.textName, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      width: MediaQuery.of(context).size.width * 0.43,
      height: 110,
      decoration: BoxDecoration(
        color: colorFont?.withOpacity(0.4),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            textName!,
            style: TextStyle(fontSize: 18, color: colorFont),
          ),
          Text(
            textPrice!,
            style: TextStyle(
                fontSize: sizeFont,
                color: colorFont,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class InformationSearch extends StatelessWidget {
  String? urlImage;
  String? textName;
  String? textTime;
  String? textPrice;

  InformationSearch(
      {this.urlImage, this.textName, this.textTime, this.textPrice, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 75,
        child: Row(
          children: [
            Image.asset(
              urlImage!,
              width: 38,
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textName!,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  textTime!,
                  style: const TextStyle(fontSize: 15, color: Colors.white54),
                )
              ],
            ),
            const Spacer(),
            Center(
              child: Text(
                textPrice!,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white70,
            )
          ],
        ));
  }
}
