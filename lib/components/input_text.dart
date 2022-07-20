import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:translation_app/components/action_button.dart';
import 'package:translation_app/components/customcard.dart';
import 'package:translation_app/provider/translator.dart';
import 'package:translator/translator.dart';
import 'package:clipboard/clipboard.dart';
import 'package:speech_to_text/speech_to_text.dart' as stts;

class InputText extends StatefulWidget {
  const InputText({Key? key}) : super(key: key);

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  final translator = GoogleTranslator();
  TextEditingController _textEditingController = TextEditingController();
  var text;
  bool islistening = false;
  var _speechToText = stts.SpeechToText();
  void listen() async {
    if (!islistening) {
      bool available = await _speechToText.initialize(
          onStatus: (status) => print('$status'),
          onError: ((errorNotification) => print('$errorNotification')));
      if (available) {
        setState(() {
          islistening = true;
        });
        _speechToText.listen(
            onResult: (result) => setState(() {
                  text = result.recognizedWords;
                }));
      }
    } else {
      setState(() {
        islistening = false;
      });
      _speechToText.stop();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _speechToText = stts.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    String fromLanguage =
        Provider.of<TranslatorData>(context).fromLanguagevalue;
    String toLanguage = Provider.of<TranslatorData>(context).toLanguageValue;

    return CustomCard(
      expandedChild: TextField(
        controller: _textEditingController,
        autocorrect: true,
        autofocus: true,
        onChanged: (value) async {
          if (value.isEmpty) {
            text = '';
            Provider.of<TranslatorData>(context, listen: false)
                .updateText(text: '');
          } else {
            text = await translator.translate(value,
                from: fromLanguage, to: toLanguage);
            Provider.of<TranslatorData>(context, listen: false)
                .updateText(text: text.toString());
          }
        },
        maxLines: 12,
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration(
          hintText: 'Enter text',
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
      actionButtonList: [
        ActionButton(
          iconData: Icons.copy,
          onPressed: () => FlutterClipboard.copy(_textEditingController.text),
        ),
        ActionButton(
          iconData: Icons.paste,
          onPressed: () {
            FlutterClipboard.paste().then((value) async {
              setState(() {
                _textEditingController.text += value;
              });
              text = await translator.translate(value,
                  from: fromLanguage, to: toLanguage);
              Provider.of<TranslatorData>(context, listen: false)
                  .updateText(text: text);
            });
          },
        ),
        ActionButton(
          iconData: Icons.close,
          onPressed: () => _textEditingController.clear(),
        ),
        SizedBox(
          width: 10.0,
        ),
        AvatarGlow(
          animate: islistening,
          repeat: true,
          endRadius: 30,
          glowColor: Colors.red,
          duration: Duration(milliseconds: 1000),
          child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                listen();
              },
              child: Icon(islistening ? Icons.mic : Icons.mic_none)),
        ),
      ],
      cardColor: Colors.white,
    );
  }
}
