import 'package:flutter/services.dart';

import '../validator_mixin.dart';

class CardNoFormatter extends TextInputFormatter with ValidatorMixin {
  String? previousText;
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.trim();

    if (newValue.selection.baseOffset == 0) return newValue;

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (numberRegExp.hasMatch(text[i])) buffer.write(text[i]);
      if ((i+2) % 5 == 0) {
        buffer.write(' ');
      }
    }

    previousText = text;
    var string = buffer.toString().trim();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
