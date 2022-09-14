import 'dart:math';

 
import 'package:flutter/services.dart';

import '../validator_mixin.dart';

class DateFormatter extends TextInputFormatter with ValidatorMixin {
  int get _maxChars => dayMonthOnly ? 4 : 8;
  final bool dayMonthOnly;

  DateFormatter([this.dayMonthOnly = true]);
  String previousText = '';

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    print('value: ${oldValue.text}');
    previousText = oldValue.text;
    var text = dayMonthOnly
        ? _formatMontYearOnly(newValue.text, '/')
        : _format(newValue.text, '/');
    return newValue.copyWith(
        text: text, selection: updateCursorPosition(text));
  }

/// format to day/month/year
  String _format(String value, String seperator) {
    value = value.replaceAll(seperator, '');
    var newString = '';

    for (int i = 0; i < min(value.length, _maxChars); i++) {
      newString += value[i];
      if ((i == 1 || i == 3) && i != value.length - 1) {
        newString += seperator;
      }
    }

    return newString;
  }

  String _addSeparator(String value) {
    var newString = '';
    int? firstDigit;
    int? secondDigit;
    if (value.length > 0 && numberRegExp.hasMatch(value[0])) {
      firstDigit = int.tryParse(value[0]);
      if (firstDigit != null && firstDigit > 1) newString += '0';
      newString += value[0];
    }
    if (value.length > 1 && numberRegExp.hasMatch(value[1])) {
      secondDigit = int.tryParse(value[1]);
      if (secondDigit != null &&
          (firstDigit == 0 || (firstDigit == 1 && secondDigit <= 2)))
        newString += value[1];
      else {
        newString = '0$firstDigit/$secondDigit';
      }
    }

    if (newString.length == 2) newString += '/';
    return newString;
  }

/// format as only month and year --- month/year
  String _formatMontYearOnly(String value, String seperator) {
    // print('previousText: $previousText');
    // print('value: $value');
    if (previousText.length > value.length && previousText.endsWith(seperator))
      return value;
    value = value.replaceAll(seperator, '');
    value = value.replaceAll(' ', '');
    var newString = '';

    newString = _addSeparator(value);
    if (newString.length == 3)
      for (int i = 2; i < min(value.length, _maxChars); i++) {
        if (numberRegExp.hasMatch(value[i])) newString += value[i];
      }
    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}
