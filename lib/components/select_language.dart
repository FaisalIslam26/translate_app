import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translation_app/provider/translator.dart';
import 'package:translation_app/screens/languages/language_page.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({Key? key}) : super(key: key);

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      height: 80,
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          buildLanguageButton(
            theme: theme,
            languageTitle:
                Provider.of<TranslatorData>(context).fromLanguageLabel,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LanguagePage(),
                settings: RouteSettings(arguments: 'From'),
              ),
            ),
          ),
          buildSwitchLanguageButton(context, theme: theme),
          buildLanguageButton(
            theme: theme,
            languageTitle: Provider.of<TranslatorData>(context).toLanguageLabel,
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => LanguagePage()),
                  settings: RouteSettings(arguments: 'To'),
                )),
          )
        ],
      ),
    );
  }

  Material buildSwitchLanguageButton(context, {theme}) {
    var provider = Provider.of<TranslatorData>(context);
    return Material(
      color: theme.primaryColor,
      child: IconButton(
        onPressed: () {
          var toLanLabel = provider.toLanguageLabel;
          var toLanValue = provider.toLanguageValue;
          var fromLanLabel = provider.fromLanguageLabel;
          var fromLanValue = provider.fromLanguagevalue;

          Provider.of<TranslatorData>(context, listen: false)
              .updateFromLanguage(label: toLanLabel, value: toLanValue);

          Provider.of<TranslatorData>(context, listen: false)
              .updateToLanguage(label: fromLanLabel, value: fromLanValue);

          Provider.of<TranslatorData>(context, listen: false).clearText();
        },
        icon: Icon(Icons.compare_arrows),
        color: Colors.white,
      ),
    );
  }

  Expanded buildLanguageButton({
    theme,
    Function()? onTap,
    required String languageTitle,
  }) {
    return Expanded(
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: theme.primaryColor,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  languageTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
