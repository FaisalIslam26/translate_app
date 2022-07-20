import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:provider/provider.dart';
import 'package:translation_app/components/action_button.dart';
import 'package:translation_app/components/customcard.dart';
import 'package:translation_app/provider/translator.dart';

class TranslateText extends StatelessWidget {
  const TranslateText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TranslatorData>(context);
    return CustomCard(
      cardColor: Colors.purple[50]!,
      expandedChild: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 10.0),
        child: Text(
          provider.translatedData,
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
      actionButtonList: [
        ActionButton(
          iconData: Icons.copy,
          onPressed: () => FlutterClipboard.copy(provider.translatedData),
        ),
        SizedBox(
          width: 20.0,
        ),
      ],
    );
  }
}
