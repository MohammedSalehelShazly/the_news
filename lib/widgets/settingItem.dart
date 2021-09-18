
import 'package:flutter/material.dart';
import '../localization/language_constants.dart';

class SettingItem extends StatelessWidget {

  String txtKey;
  Function onTap;
  Widget trailing;

  SettingItem({
    @required this.txtKey,
    @required this.trailing,
    @required this.onTap,

  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        getTranslated(context, txtKey),
      ),
      trailing: trailing,
      onTap: onTap,

    );
  }
}
