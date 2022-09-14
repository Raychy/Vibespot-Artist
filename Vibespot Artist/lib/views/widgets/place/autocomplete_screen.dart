import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_place/google_place.dart';
import 'package:vsartist/constants/app_colors.dart';
import 'package:vsartist/core/env.dart';
import 'package:vsartist/core/theme/app_theme.dart';

import 'place_mixin.dart';

class AutocompleteScreen extends StatefulWidget {
  const AutocompleteScreen({Key? key}) : super(key: key);

  @override
  _AutocompleteScreenState createState() => _AutocompleteScreenState();
}

class _AutocompleteScreenState extends State<AutocompleteScreen>
    with PlaceMixin {
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];

  @override
  void initState() {
    // print(GetIt.I<Env>().googleApiKey);
    googlePlace = GooglePlace(GetIt.I<Env>().googleApiKey);
    super.initState();
  }

  void _autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    print(result?.predictions?.map((e) => {
          'distanceMeters': e.distanceMeters,
          'description': e.description,
          '': e.matchedSubstrings
        }));
    print(result?.status);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.dark,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Material(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.BACKGROUND_COLOR,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 20),
                CloseButton(),
                // SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.PRIMARY)),
                        // labelText: "Search",
                        hintText: 'Type in address here'),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        _autoCompleteSearch(value);
                      } else {
                        if (predictions.length > 0 && mounted) {
                          setState(() {
                            predictions = [];
                          });
                        }
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: predictions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.pin_drop,
                            // color: Colors.white,
                          ),
                        ),
                        title: Text(predictions[index].description ?? ''),
                        onTap: () async {
                          var result = await googlePlace.details
                              .get(predictions[index].placeId ?? '');

                          // print(placeToAddress(result!.result!));
                          if (result != null && result.result != null)
                            Navigator.of(context)
                                .pop(placeToAddress(result.result!));
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
