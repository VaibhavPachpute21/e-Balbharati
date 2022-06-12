// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Classes {
  String className;
  String classValue;
  Classes({required this.className, required this.classValue});
}

List<Classes> myClasses = [
  Classes(className: "इयत्ता पहिली", classValue: "1st"),
  Classes(className: "इयत्ता दूसरी", classValue: "2nd"),
  Classes(className: "इयत्ता तिसरी", classValue: "3rd"),
  Classes(className: "इयत्ता चौथी", classValue: "4th"),
  Classes(className: "इयत्ता पाचवी", classValue: "5th"),
  Classes(className: "इयत्ता सहावी", classValue: "6th"),
  Classes(className: "इयत्ता सातवी", classValue: "7th"),
  Classes(className: "इयत्ता आठवी", classValue: "8th"),
  Classes(className: "इयत्ता नववी", classValue: "9th"),
  Classes(className: "इयत्ता दहावी", classValue: "10th"),
  Classes(className: "इयत्ता अकरावी", classValue: "11th"),
  Classes(className: "इयत्ता बारावी", classValue: "12th")
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ई-बालभारती",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
          bottom: PreferredSize(
            child: Container(
              child: Text("कृपया आपली इयत्ता निवडा",style: TextStyle(fontSize: 18 ),),
            ),
            preferredSize: Size(50, 15),
           ),
        ),
        body: ListView.builder(
            itemCount: myClasses.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  print(myClasses[index].classValue);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(1),
                  child: CircleAvatar(
                    radius: 100.0,
                    child: Text(
                      myClasses[index].className,
                      style: TextStyle(fontSize: 22),
                    ),
                    backgroundImage: AssetImage("./assets/images/bg.png"),
                  ),
                ),
              );
            }));
  }
}
