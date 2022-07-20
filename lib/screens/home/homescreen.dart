import 'package:flutter/material.dart';
import 'package:translation_app/components/input_text.dart';
import 'package:translation_app/components/select_language.dart';
import 'package:translation_app/components/translate_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Translate'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SelectLanguage(),
            InputText(),
            TranslateText(),
          ],
        ),
      ),
    );
  }
}
