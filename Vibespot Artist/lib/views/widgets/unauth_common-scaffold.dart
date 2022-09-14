import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:vsartist/views/common/uidata.dart';
import 'package:vsartist/views/widgets/drawer.dart';

class UnAuthCommonScaffold extends StatelessWidget {
  final String? appTitle;
  final Widget? bodyData;
  final Widget? floatingActionButton;
  final dynamic leading;
  final dynamic scaffoldState;
  final elevation;
  final backGroundColor;
  final showDrawer;

  UnAuthCommonScaffold(
      {this.appTitle,
      this.bodyData,
      this.scaffoldState,
      this.leading,
      this.floatingActionButton,
      this.elevation = 4.0,
      this.backGroundColor,
      this.showDrawer});

  @override
  Widget build(BuildContext context) {
    return   WillPopScope(
            onWillPop: () async {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  UiData.accountLander, (Route<dynamic> route) => false);
              return false;
            },
            child: Scaffold(
                key: scaffoldState,
                appBar: appTitle != null
                    ? new AppBar(
                        brightness: Brightness.dark,
                        elevation: elevation,
                        leading: leading,
                        centerTitle: true,
                        iconTheme: Theme.of(context).iconTheme
                            .copyWith(color: Colors.white),
                        title: Text(
                          appTitle!,
                          style: Theme.of(context).textTheme.headline4
                              ?.copyWith(color: Colors.white),
                        ),
                        backgroundColor: Theme.of(context).backgroundColor,
                      )
                    : null,
                drawer: showDrawer ? CommonDrawer() : null,
                backgroundColor: Theme.of(context).backgroundColor,
                body: bodyData,
                floatingActionButton: floatingActionButton),
          ); 
  }
}
