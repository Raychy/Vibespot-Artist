import 'package:flutter/material.dart';
import 'package:vsartist/constants/app_colors.dart';  

RoundedRectangleBorder get cardShape => RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
    side: BorderSide(width: .3, color: AppColors.DARK_GREY.withOpacity(.4)));
