// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vsartist/views/widgets/drawer.dart';

class ScaffoldCommon extends StatelessWidget {
  final String? appTitle;
  final Widget? bodyData;
  final Widget? floatingActionButton;
  final Widget? leading;
  // final GlobalKey<ScaffoldState>? scaffoldState;
  final elevation;
  final backGroundColor;
  final bool showDrawer;

  ScaffoldCommon(
      {this.appTitle,
      this.bodyData,
      // this.scaffoldState,
      this.leading,
      this.floatingActionButton,
      this.elevation = 4.0,
      this.backGroundColor,
      this.showDrawer = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // key: scaffoldState,
        resizeToAvoidBottomInset: true,
        appBar: appTitle != null
            ? AppBar(
                // elevation: elevation,
                leading: leading,
                centerTitle: true,
                iconTheme: Theme.of(context).iconTheme,
                title: Text(
                  appTitle!,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                backgroundColor: Theme.of(context).primaryColor,
              )
            : null,
        drawer: showDrawer ? CommonDrawer() : null,
        backgroundColor: Theme.of(context).backgroundColor,
        body: bodyData,
        floatingActionButton: floatingActionButton);
  }
}
