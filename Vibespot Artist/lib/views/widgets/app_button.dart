import 'package:flutter/material.dart';
import 'package:vsartist/constants/app_colors.dart';

class AppButton extends StatelessWidget {
  final Function()? onPressed;
  final String label;
  final Color color, textColor;
  const AppButton(
      {Key? key,
      this.onPressed,
      required this.label,
      this.color = AppColors.PRIMARY,
      this.textColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
              Size(100, kMinInteractiveDimension + 4)),
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(label,
            style: TextStyle(
                fontSize: 17, color: textColor, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
