import 'package:flutter/material.dart';
import 'package:vsartist/constants/app_colors.dart';
import 'package:vsartist/core/router/app_route.dart';
import 'package:vsartist/views/account/login.dart';
import 'package:vsartist/views/account/signup.dart';
import 'package:vsartist/views/common/uidata.dart';
import 'package:vsartist/views/widgets/app_button.dart';
import 'package:vsartist/views/widgets/forms.dart';

class AccountLander extends StatelessWidget implements AppRoute {
  @override
  String get routeNam => routeName;

  static String get routeName => 'account-lander';

  @override
  Widget get page => this;
  final scaffoldState = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final FormsWidget formsWidget = FormsWidget();
  @override
  Widget build(BuildContext context) {
    return Material(
      // padding: EdgeInsets.symmetric(horizontal: 30),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(children: <Widget>[
          Spacer(),
          formsWidget.appIcon(),
          _startedText(context),
          SizedBox(height: MediaQuery.of(context).size.height * 0.10),
          // signupButton(context, 'an Artist', 'an Artist', UiData.login),
          // signupButton(context, 'a Record Label', 'a Record Label',
          // UiData.recordLabelLogin),
          Spacer(),
          SizedBox(
              width: 400,
              child: AppButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(Login.routeName);
                  },
                  label: 'Login',
                  color: Colors.white,
                  textColor: AppColors.PRIMARY)),
          SizedBox(height: 20),
          SizedBox(
              width: 400,
              child: AppButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(SignUp.routeName);
                  },
                  label: 'Create Account')),
          SizedBox(height: 50),
        ]),
      ),
    );
  }

  Widget _login(context) {
    return new GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(UiData.login);
      },
      child: new Container(
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(0, 10, 0, 50),
//        padding: const EdgeInsets.all(5),
        child: Row(children: [
          new Text(
            'Already have an account? ',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.orange,
            ),
          ),
          new Text('Log in',
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ))
        ]),
      ),
    );
  }

  Widget _startedText(BuildContext context) {
    return SizedBox(
      width: 600,
      child: Center(
        child: new Text(
          "VibeSpot, a platform where Artist can sell their songs and also be rest assured that they would get local listeners in their area.",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(fontWeight: FontWeight.w300, fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget signupButton(context, title1, title2, signup) {
    return InkWell(
      onTap: () => Navigator.of(context).pushReplacementNamed(signup),
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: myBoxDecoration(), //             <--- BoxDecoration here
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title1 == 'Artist' ? 'Are you $title1?' : 'Are you $title1?',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              'Login as $title2',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      shape: BoxShape.rectangle,
      color: Colors.white,
      border: Border(
        left: BorderSide(
          color: UiData.orange,
          width: 5.0,
        ),
      ),
    );
  }
}
