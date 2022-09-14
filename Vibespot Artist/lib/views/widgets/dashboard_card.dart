import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vsartist/constants/app_colors.dart';
import 'package:vsartist/core/router/route_transisions.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard(
      {Key? key,
      required this.title,
      required this.routeName,
      required this.icon,
      this.action})
      : super(key: key);
  final String title, routeName;
  final String icon;
  final Function()? action;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
        height: (width / 2.5),
        // width: width * .6,
        child: Card(
            elevation: 0.0,
            margin: EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0)),
            color: AppColors.PRIMARY,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black, // AppColors.BACKGROUND_COLOR,
                  borderRadius: BorderRadius.circular(14)),
              child: InkWell(
                onTap: action ??
                    () {
                      Navigator.of(context).pushNamed(routeName,
                          arguments: Transissions.slide_left);
                    },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    // SizedBox(height: 25.0),
                    Center(
                        child: SizedBox(
                      height: 40,
                      child: SvgPicture.asset(
                        icon,
                        // size: 40.0,
                        color: AppColors.PRIMARY,
                      ),
                    )),
                    SizedBox(height: 20.0),
                    Center(
                      child: Text(title,
                          style: TextStyle(
                              fontSize: 14.0,
                              color: AppColors.PRIMARY,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(height: 10.0),
                    // Spacer()
                  ],
                ),
              ),
            )));
  }
}
