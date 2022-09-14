import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vsartist/core/router/app_route.dart';
import 'package:vsartist/views/artist_features/artist_global/networks.dart';
import 'package:vsartist/views/widgets/forms.dart';

import 'cubit/login_cubit.dart';

class ForgotPassword extends StatefulWidget implements AppRoute {
  @override
  String get routeNam => routeName;

  static String get routeName => 'forgot-password';

  @override
  Widget get page => this;
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  //ForgotPasswordRequest loginRequest;
  final scaffoldState = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FormsWidget formsWidget = FormsWidget();

  // ForgetPasswordModel forgetPasswordModel =  ForgetPasswordModel();

  late LoginCubit _cubit;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  FocusNode _emailNode = FocusNode();

  @override
  void initState() {
    _cubit = LoginCubit();
    super.initState();
    checkInternet();
  }

  @override
  dispose() {
    super.dispose();
    _cubit.close();
  }

  checkInternet() async {
    if (await networkBloc.checkInternet() != null)
      _showSnackBar(await (networkBloc.checkInternet() as FutureOr<String>));
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Future<bool> loginAction() async {
    //replace the below line of code with your login request
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  void _submit() async {
    setState(() {
      autovalidateMode = AutovalidateMode.onUserInteraction;
    });
    final form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      _cubit.forgotPassword(context);
    }
  }

  Widget loginScaffold() => _forgotPasswordContainer();

  _forgotPasswordContainer() {
    return Material(
        child: SafeArea(
      child: Stack(
        children: [
          Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50),
              formsWidget.appIcon(),
              _formContainer(),
            ],
          ),
          Positioned(top: 20, left: 10, child: BackButton())
        ],
      ),
    ));
  }

  Widget _formContainer() {
    return Container(
      child: Form(
          key: formKey,
          child: Theme(
              data: ThemeData(primarySwatch: Colors.orange),
              child: Column(
                children: <Widget>[
                  formsWidget.sectionBody(
                      'Kindly supply your email address to reset your password',
                      size: 14.0,
                      position: TextAlign.center),
                  SizedBox(
                    height: 100.0,
                  ),
                  _usernameContainer(),
                  SizedBox(height: 70),
                  loginButto(),
                  SizedBox(height: 20),
                ],
              ))),
      margin: EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
    );
  }

  Widget _usernameContainer() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
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
            _submit();
          },
          decoration: formsWidget.formDecoration('Email', icon: Icons.email),
        ));
  }

  loginButto() {
    return BlocBuilder<LoginCubit, LoginState>(
        bloc: _cubit,
        builder: (context, state) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: formsWidget.wideButton('FORGOT PASSWORD', context, _submit,
                isLoading: state.isLoading,
                disable: _cubit.emailValidator(state.email ?? '') != null ||
                    state.isLoading)));
  }

  @override
  Widget build(BuildContext context) {
    return loginScaffold();
  }
}
