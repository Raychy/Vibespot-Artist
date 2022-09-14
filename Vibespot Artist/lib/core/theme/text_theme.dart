// class

import 'package:flutter/material.dart'; 
import 'package:vsartist/constants/dimens.dart';

TextTheme get textTheme => TextTheme(
      bodyText1:
          TextStyle(fontSize: Dimens.FONT_NORMAL, fontWeight: FontWeight.w400),
      bodyText2:
          TextStyle(fontSize: Dimens.FONT_NORMAL, fontWeight: FontWeight.w300),
      caption:
          TextStyle(fontSize: Dimens.FONT_SMALL, fontWeight: FontWeight.w300),
      headline5:
          TextStyle(fontSize: Dimens.FONT_MEDIUM, fontWeight: FontWeight.w600),
      headline4:
          TextStyle(fontSize: Dimens.FONT_MEDIUM, fontWeight: FontWeight.w900),
    );
