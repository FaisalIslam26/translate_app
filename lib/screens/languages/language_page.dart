import 'package:flutter/material.dart';

import 'package:translation_app/provider/translator.dart';
import 'package:translation_app/screens/languages/language_list.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text('Language'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: languageList.length,
                itemBuilder: ((context, index) {
                  String key = languageList.keys.elementAt(index);
                  return Column(
                    children: [
                      ListTile(
                        title: Text("${languageList[key]}"),
                        onTap: () {
                          if (args == 'From') {
                            Provider.of<TranslatorData>(context, listen: false)
                                .updateFromLanguage(
                                    label: languageList[key]!, value: key);
                          } else if (args == 'To') {
                            Provider.of<TranslatorData>(context, listen: false)
                                .updateToLanguage(
                                    label: languageList[key]!, value: key);
                          }

                          Navigator.pop(context);
                        },
                      ),
                      Divider(
                        height: 2.0,
                      ),
                    ],
                  );
                })),
          )
        ],
      ),
    );
  }
}
