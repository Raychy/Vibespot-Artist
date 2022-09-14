import 'package:flutter/material.dart';
import 'package:vsartist/core/router/route_transisions.dart';

import 'forms.dart';

class UploadInstruction extends StatelessWidget {
  final String routeName;
  const UploadInstruction({Key? key, required this.routeName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    nextButton() {
      Navigator.of(context)
          .pushReplacementNamed(routeName, arguments: Transissions.slide_left);
    }

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //instructionHead1("Song Upload Guide"),
            SizedBox(height: 20.0, width: MediaQuery.of(context).size.width),
            Text(
                "Before you begin, make sure you have your assets prepared and available on your phone.",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 14)),
            // instructionSubHead1(
            //     "Before you begin, make sure you \n have your assets prepared and \n available on your phone."),
            SizedBox(height: 15.0),
            Text("Cover art requirements:",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    // color: Colors.white,
                    fontSize: 18)),
            Text("Cover image must not be blurry.",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 14)),
            SizedBox(height: 15.0),
            Text("Music/audio file requirements:",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    // color: Colors.white,
                    fontSize: 18)),
            Text("wav-file, .mp3-file.",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 14)),
            // instructionHead1("Cover art requirements:"),
            // SizedBox(height: 10.0),
            // instructionSubHead1("Clear cover image, no blurry."),
            // SizedBox(height: 25.0),
            // instructionHead1("Music/audio file requirements:"),
            // SizedBox(height: 10.0),
            // instructionSubHead1(".wav-file, .mp3-file."),
            Spacer(),

            SizedBox(height: 40.0),
            FormsWidget().wideButton('PROCEED', context, nextButton),
            SizedBox(height: 50.0),
          ]),
    );
  }
}
