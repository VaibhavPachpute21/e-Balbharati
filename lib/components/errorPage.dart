// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(child: Image.asset("./assets/images/error.png",fit: BoxFit.fitWidth,)),
    );
  }
}
