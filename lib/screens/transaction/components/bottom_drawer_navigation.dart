import 'package:flutter/material.dart';
import 'package:myapp_nhat_2022/constants/constants.dart';

class BottomDrawerNavigation extends StatefulWidget{
  const BottomDrawerNavigation({Key? key}) : super(key: key);
  @override
  _BottomDrawerNavigationState createState() =>   _BottomDrawerNavigationState();

}

class _BottomDrawerNavigationState  extends State<BottomDrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: Colors.indigoAccent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
        height: 56.0,
        child: IconButton(
            onPressed: showMenu,
            icon: const Icon(IconData(0xf7f8, fontFamily: 'MaterialIcons'),size: 45,),
            color: Colors.white,
          ),
      ),
      );
  }

  showMenu() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: getHeight(500),
            decoration:  const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Colors.indigoAccent,
            ),
            child: ListView(
              children: [
                Column(
                  children:  [
                    IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: const Icon(IconData(0xf7f8, fontFamily: 'MaterialIcons'),size: 45,),
                      color: Colors.white,
                    ),
                    searchField(context),
                    InformationSearch(
                      urlImage: 'assets/images/Shopping Icon.png',
                      textName:'Shopping',
                      textTime: '15 March 2019, 8:20 PM',
                      textPrice: '-\$120',
                    ),
                    InformationSearch(
                      urlImage: 'assets/images/Shopping Icon-1.png',
                      textName:'Medicine',
                      textTime: '12 March 2019, 12:10 AM',
                      textPrice: '-\$89.50',
                    ),
                    InformationSearch(
                      urlImage: 'assets/images/Ellipse 14.png',
                      textName:'Sport',
                      textTime: '15 March 2019, 8:20 PM',
                      textPrice: '-\$120',
                    ),
                    InformationSearch(
                      urlImage: 'assets/images/Ellipse 14-1.png',
                      textName:'Shopping',
                      textTime: '15 March 2019, 8:20 PM',
                      textPrice: '-\$120',
                    ),
                    InformationSearch(
                      urlImage: 'assets/images/Ellipse 14-2.png',
                      textName:'Travel',
                      textTime: '15 March 2019, 8:20 PM',
                      textPrice: '-\$120',
                    ),
                    InformationSearch(
                      urlImage: 'assets/images/Shopping Icon.png',
                      textName:'Sport',
                      textTime: '15 March 2019, 8:20 PM',
                      textPrice: '-\$120',
                    ),

                  ],
                )
              ],
            ),
          );
        }
    );
  }


  Widget searchField(BuildContext context){
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(15),
      ),
      child:  const TextField(
        style: TextStyle(color: Colors.white, fontSize: 20),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.white54,fontSize: 20),
          prefixIcon:  Icon(Icons.search, color: Colors.white54,size: 25,),
        ),
      ),
    );
  }



}
class InformationSearch extends StatelessWidget{
  String? urlImage;
  String? textName;
  String? textTime;
  String? textPrice;

  InformationSearch({this.urlImage,this.textName,this.textTime,this.textPrice,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 55,
        child: Row(
          children: [
            Image.asset(urlImage!,width: 38,),
            const SizedBox(width: 5,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Text(textName!,style: const TextStyle(fontSize: 18,color: Colors.white),),
                Text(textTime!,style: const TextStyle(fontSize: 15, color: Colors.white54),)
              ],
            ),
            const Spacer(),
            Center(
              child: Text(textPrice!,style: const TextStyle(fontSize: 18,color: Colors.white),),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white70,)
          ],
        )
    );
  }
}
