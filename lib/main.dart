import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translation_app/constants.dart';
import 'package:translation_app/provider/translator.dart';
import 'package:translation_app/screens/home/homescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TranslatorData(),
      child: MaterialApp(
        title: 'Google Translate',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.blueGrey,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
