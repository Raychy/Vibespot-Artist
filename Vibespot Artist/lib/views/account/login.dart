import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vsartist/constants/app_colors.dart';
import 'package:vsartist/core/router/app_route.dart';
import 'package:vsartist/views/account/cubit/login_cubit.dart';
import 'package:vsartist/views/account/forgot_password.dart';
import 'package:vsartist/views/account/signup.dart';
import 'package:vsartist/views/artist_features/artist_global/networks.dart';
import 'package:vsartist/views/common/shared-data.dart';
import 'package:vsartist/views/widgets/forms.dart';

class Login extends StatefulWidget implements AppRoute {
  @override
  String get routeNam => routeName;

  static String get routeName => 'login';

  @override
  Widget get page => this;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //LoginRequest loginRequest;
  NetworkRequest network = NetworkRequest();
  SharedData _pref = SharedData();
  final scaffoldState = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  FormsWidget formsWidget = FormsWidget();
  bool _isPasswordObscure = true;
  String? userType;
  late LoginCubit _cubit;

  FocusNode _emailNode = FocusNode();
  FocusNode _passNode = FocusNode();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  void initState() {
    _cubit = LoginCubit();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    _cubit.close();
  }

  Future<bool> loginAction() async {
    //replace the below line of code with your login request
    await new Future.delayed(const Duration(seconds: 1));
    return true;
  }

  void _submit() async {
    setState(() {
      autovalidateMode = AutovalidateMode.onUserInteraction;
    });
    final form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      _cubit.login(context);
    }
  }

  Widget loginScaffold() => _loginContainer();

  _loginContainer() {
    return _formContainer();
  }

  Widget _formContainer() {
    return Material(
      child: SafeArea(
        child: Container(
          // width: 600,
          // constraints: BoxConstraints.loose(Size(600, 1000)),
          child: AutofillGroup(
            child: Form(
                key: formKey,
                child: Theme(
                    data: ThemeData(primarySwatch: Colors.orange),
                    child: ListView(
                      children: <Widget>[
                        SizedBox(height: 50),
                        formsWidget.appIcon(),
                        SizedBox(height: 100),
                        _emailContainer(),
                        _passwordContainer(),
                        forgotPassword(),
                        SizedBox(height: 20),
                        loginButton(),
                        SizedBox(height: 20),
                        _registerNowLabel(),
                      ],
                    ))),
          ),
          margin: EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
        ),
      ),
    );
  }

  Widget _emailContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
          onChanged: _cubit.emailChanged,
          style: TextStyle(color: Colors.white),
          validator: _cubit.emailValidator,
          autocorrect: false,
          autovalidateMode: autovalidateMode,
          focusNode: _emailNode,
          autofillHints: [AutofillHints.email],
          onFieldSubmitted: (text) {
            _emailNode.unfocus();
            _passNode.requestFocus();
          },
          decoration:
              formsWidget.formDecoration('Email Address', icon: Icons.email)),
    );
  }

  Widget _passwordContainer() {
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: _cubit,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextFormField(
              style: TextStyle(color: Colors.white),
              obscureText: _isPasswordObscure,
              onChanged: _cubit.passwordChanged,
              autocorrect: false,
              autovalidateMode: autovalidateMode,
              focusNode: _passNode,
              autofillHints: [AutofillHints.email],
              validator: _cubit.passwordValidator,
              onFieldSubmitted: (text) {
                _passNode.unfocus();
                formKey.currentState?.validate();
                setState(() {
                  autovalidateMode = AutovalidateMode.onUserInteraction;
                });
              },
              decoration: formsWidget.formDecoration(
                'Password',
                icon: Icons.vpn_key,
                suffixIcon: IconButton(
                  icon: Icon(
                      _isPasswordObscure
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _isPasswordObscure = !_isPasswordObscure;
                    });
                  },
                ),
              )),
        );
      },
    );
  }

  forgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30.0, right: 15.0, top: 20.0),
        child: InkWell(
            child: Text(
              'Forgot Password',
              style: TextStyle(color: AppColors.PRIMARY, fontSize: 15),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(ForgotPassword.routeName);
            }),
      ),
    );
  }

  Widget _registerNowLabel() {
    return new GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(SignUp.routeName);
      },
      child: Container(
          alignment: Alignment.center,
          child: Text.rich(
            TextSpan(children: [
              TextSpan(text: 'New Artist?'),
              TextSpan(
                  text: '  Register Now!',
                  style: TextStyle(
                      color: AppColors.PRIMARY, fontWeight: FontWeight.bold))
            ]),
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.w300),
          ),
          margin: EdgeInsets.only(bottom: 30.0)),
    );
  }

  loginButton() {
    return BlocBuilder<LoginCubit, LoginState>(
        bloc: _cubit,
        builder: (context, state) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: formsWidget.wideButton('LOGIN', context, _submit,
                isLoading: state.isLoading,
                disable: !_cubit.loginValid || state.isLoading)));
  }

  @override
  Widget build(BuildContext context) {
    return loginScaffold();
  }
}
