import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vsartist/views/artist_features/artist_global/networks.dart';
import 'package:vsartist/views/widgets/forms.dart';
import 'package:vsartist/views/widgets/otp/otp_form.dart';

import 'cubit/login_cubit.dart';

class ResetPassword extends StatefulWidget {
  final String email;

  const ResetPassword({Key? key, required this.email}) : super(key: key);
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  // final scaffoldState = ScaffoldMessenger.of(context);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FormsWidget formsWidget = FormsWidget();

  late LoginCubit _cubit;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  FocusNode _emailNode = FocusNode();
  FocusNode _passNode = FocusNode();

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
      _cubit.resetPassword(context, widget.email);
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
              // SizedBox(height: 30),
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
                    height: 40.0,
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
                    bloc: _cubit,
                    builder: (context, state) {
                      return OtpForm(
                        // formaters: [Number],
                        count: 6,
                        inputType: TextInputType.number,
                        otp: state.otp ?? '',
                        onChanged: (text) {
                          _cubit.otpChanged(text);
                          if (text.length == 6) {
                            _emailNode.requestFocus();
                          }
                        },
                      );
                    },
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        onChanged: _cubit.passwordChanged,
                        style: TextStyle(color: Colors.white),
                        validator: _cubit.passwordValidator,
                        autocorrect: false,
                        obscureText: true,
                        autovalidateMode: autovalidateMode,
                        focusNode: _emailNode,
                        autofillHints: [AutofillHints.newPassword],
                        onFieldSubmitted: (text) {
                          _emailNode.unfocus();
                          _passNode.requestFocus();
                          // _submit();
                        },
                        decoration: formsWidget.formDecoration('New Password',
                            icon: Icons.lock),
                      )),
                   BlocBuilder<LoginCubit, LoginState>(
                    bloc: _cubit,
                    builder: (context, state)=>Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        onChanged: _cubit.confirmPasswordChanged,
                        style: TextStyle(color: Colors.white),
                        validator:(pass)=> _cubit.confirmPasswordValidator(state.password ??'', pass!),
                        autocorrect: false,
                        obscureText: true,
                        autovalidateMode: autovalidateMode,
                        focusNode: _passNode,
                        autofillHints: [AutofillHints.newPassword],
                        onFieldSubmitted: (text) {
                          _passNode.unfocus();
                          _submit();
                        },
                        decoration: formsWidget.formDecoration(
                            'Password confirmation',
                            icon: Icons.lock),
                      ))),
                  SizedBox(height: 20),
                  loginButto(),
                  SizedBox(height: 20),
                ],
              ))),
      margin: EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
    );
  }

  loginButto() {
    return BlocBuilder<LoginCubit, LoginState>(
        bloc: _cubit,
        builder: (context, state) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: formsWidget.wideButton('Reset Password', context, _submit,
                isLoading: state.isLoading,
                disable: !_cubit.resetValid ||
                    state.isLoading)));
  }

  @override
  Widget build(BuildContext context) {
    return loginScaffold();
  }
}
