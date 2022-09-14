import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vsartist/constants/app_colors.dart';
import 'package:vsartist/constants/dimens.dart';
import 'package:vsartist/core/router/app_route.dart';
import 'package:vsartist/views/account/login.dart';
import 'package:vsartist/views/widgets/forms.dart';
import 'package:vsartist/views/widgets/location/cubit/location_cubit.dart';
import 'package:vsartist/views/widgets/location/location_form.dart';
import 'package:vsartist/views/widgets/place/address.dart';
import 'package:vsartist/views/widgets/place/autocomplete_screen.dart';
import 'package:vsartist/views/widgets/place/place_picker.dart';

import 'cubit/login_cubit.dart';

class SignUp extends StatefulWidget implements AppRoute {
  @override
  String get routeNam => routeName;

  static String get routeName => 'register';

  @override
  Widget get page => this;
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FormsWidget formsWidget = FormsWidget();
  final scaffoldState = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  bool _isPasswordObscure = true;
  bool _isConfirmPasswordObscure = true;
  late LoginCubit _cubit;
  late LocationCubit _locationCubit;

  FocusNode _emailNode = FocusNode();
  FocusNode _passNode = FocusNode();
  FocusNode _phoneNode = FocusNode();
  FocusNode _cPassNode = FocusNode();
  FocusNode _fNameNode = FocusNode();
  FocusNode _lNameNode = FocusNode();
  FocusNode _youtubeNode = FocusNode();
  FocusNode _usernameNode = FocusNode();
  FocusNode _stageNameNode = FocusNode();
  AutovalidateMode _autovalidateFName = AutovalidateMode.disabled;
  AutovalidateMode _autovalidateLName = AutovalidateMode.disabled;
  // AutovalidateMode _autovalidateUsername = AutovalidateMode.disabled;
  AutovalidateMode _autovalidateEmail = AutovalidateMode.disabled;
  AutovalidateMode _autovalidatePhone = AutovalidateMode.disabled;
  AutovalidateMode _autovalidatePass = AutovalidateMode.disabled;
  AutovalidateMode _autovalidateCPass = AutovalidateMode.disabled;
  AutovalidateMode _autovalidateStageName = AutovalidateMode.disabled;
  AutovalidateMode _autovalidateCity = AutovalidateMode.disabled;
  AutovalidateMode _autovalidateState = AutovalidateMode.disabled;
  AutovalidateMode _autovalidateCountry = AutovalidateMode.disabled;

  @override
  void initState() {
    _cubit = LoginCubit();
    _locationCubit = LocationCubit();
    super.initState();
  }

  @override
  dispose() {
    _locationCubit.close();
    _cubit.close();
    super.dispose();
  }

  formDecoration(title) {
    return InputDecoration(
      hintText: title,
      hintStyle: TextStyle(color: Colors.grey[400]),
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      fillColor: Colors.white,
      enabledBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 0.0),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
    );
  }

  void _pickAddress() async {
    var data = await showDialog(
        context: context, builder: (c) => AutocompleteScreen());

    if (data is Address) {
      _cubit.addressChanged(data);
      _cityController.text = data.city;
      _stateController.text = data.state;
      _countryController.text = data.country;
    }
  }

  signupFields() => Container(
        child: BlocBuilder<LoginCubit, LoginState>(
            bloc: _cubit,
            builder: (context, state) => Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.PADDING_SMALL),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    AutofillGroup(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                                autovalidateMode: _autovalidateFName,
                                focusNode: _fNameNode,
                                onChanged: _cubit.firstnameChanged,
                                textInputAction: TextInputAction.next,
                                autofillHints: [AutofillHints.givenName],
                                onEditingComplete: () {
                                  setState(() {
                                    _autovalidateFName =
                                        AutovalidateMode.always;
                                  });

                                  _lNameNode.requestFocus();
                                },
                                style: TextStyle(color: Colors.white),
                                validator: (val) {
                                  return val!.length < 4
                                      ? "Artist first name must have at least 4 chars"
                                      : null;
                                },
                                decoration: formsWidget.formDecoration(
                                    'Artist first name',
                                    icon: Icons.account_circle)),
                            separator,
                            TextFormField(
                                autovalidateMode: _autovalidateLName,
                                focusNode: _lNameNode,
                                textInputAction: TextInputAction.next,
                                onChanged: _cubit.lastnameChanged,
                                autofillHints: [AutofillHints.familyName],
                                onEditingComplete: () {
                                  setState(() {
                                    _autovalidateLName =
                                        AutovalidateMode.always;
                                  });
                                  _stageNameNode.requestFocus();
                                },
                                style: TextStyle(color: Colors.white),
                                validator: (val) {
                                  return val!.length < 4
                                      ? "Artist name must have at least 4 chars"
                                      : null;
                                },
                                decoration: formsWidget.formDecoration(
                                    'Artist last name',
                                    icon: Icons.account_circle)),
                            separator,
                            TextFormField(
                                focusNode: _stageNameNode,
                                onChanged: _cubit.stageNameChanged,
                                textInputAction: TextInputAction.next,
                                autovalidateMode: _autovalidateStageName,
                                autofillHints: [AutofillHints.newUsername],
                                onEditingComplete: () {
                                  setState(() {
                                    _autovalidateStageName =
                                        AutovalidateMode.always;
                                  });
                                  _emailNode.requestFocus();
                                },
                                style: TextStyle(color: Colors.white),
                                validator: (val) {
                                  return val!.length < 4
                                      ? "Stage name must have at least 4 chars"
                                      : null;
                                },
                                decoration: formsWidget.formDecoration(
                                    'Stage name',
                                    icon: Icons.person)),
                            separator,
                            TextFormField(
                                focusNode: _youtubeNode,
                                textInputAction: TextInputAction.next,
                                onChanged: _cubit.youtubeNameChanged,
                                style: TextStyle(color: Colors.white),
                                validator: (val) {
                                  return val!.length < 2
                                      ? "Youtube channel name must have at least 2 chars"
                                      : null;
                                },
                                decoration: formsWidget.formDecoration(
                                    'Youtube channel name',
                                    icon: Icons.tv_rounded)),
                            separator,
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              autovalidateMode: _autovalidateEmail,
                              focusNode: _emailNode,
                              onChanged: _cubit.emailChanged,
                              autofillHints: [AutofillHints.email],
                              onEditingComplete: () {
                                setState(() {
                                  _autovalidateEmail = AutovalidateMode.always;
                                });
                                _phoneNode.requestFocus();
                              },
                              style: TextStyle(color: Colors.white),
                              validator: _cubit.emailValidator,
                              decoration: formsWidget.formDecoration('Email',
                                  icon: Icons.email),
                            ),
                            separator,
                            TextFormField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.phone,
                                autovalidateMode: _autovalidatePhone,
                                focusNode: _phoneNode,
                                onChanged: _cubit.phoneChanged,
                                autofillHints: [AutofillHints.telephoneNumber],
                                onEditingComplete: () {
                                  setState(() {
                                    _autovalidatePhone =
                                        AutovalidateMode.always;
                                  });
                                  _passNode.requestFocus();
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+$')),
                                ],
                                style: TextStyle(color: Colors.white),
                                validator: (val) {
                                  return val!.length < 4
                                      ? "Phone Number must have at least 4 characters"
                                      : null;
                                },
                                decoration: formsWidget.formDecoration(
                                    'Phone Number',
                                    icon: Icons.phone)),
                            separator,
                            InkWell(
                                onTap: _pickAddress,
                                child: AbsorbPointer(
                                  child: TextFormField(
                                      controller: _cityController,
                                      // enabled: false,
                                      autovalidateMode: _autovalidateCity,
                                      // focusNode: _cPassNode,
                                      textInputAction: TextInputAction.next,
                                      onChanged: _cubit.cityChanged,
                                      onEditingComplete: () {
                                        setState(() {
                                          _autovalidateCity =
                                              AutovalidateMode.always;
                                        });
                                        // _stageNameNode.requestFocus();
                                      },
                                      style: TextStyle(color: Colors.white),
                                      validator: (val) {
                                        return val!.isEmpty
                                            ? "city name must not be empty"
                                            : null;
                                      },
                                      decoration: formsWidget.formDecoration(
                                          'City',
                                          icon: Icons.location_city)),
                                )),
                            separator,
                            InkWell(
                                onTap: _pickAddress,
                                child: AbsorbPointer(
                                  child: TextFormField(
                                      controller: _stateController,
                                      // enabled: false,
                                      autovalidateMode: _autovalidateState,
                                      // focusNode: _lNameNode,
                                      textInputAction: TextInputAction.next,
                                      onChanged: _cubit.stateChanged,
                                      onEditingComplete: () {
                                        setState(() {
                                          _autovalidateState =
                                              AutovalidateMode.always;
                                        });
                                      },
                                      style: TextStyle(color: Colors.white),
                                      validator: (val) {
                                        return val!.isEmpty
                                            ? "state name must not be empty"
                                            : null;
                                      },
                                      decoration: formsWidget.formDecoration(
                                          'State',
                                          icon: Icons.location_on_outlined)),
                                )),
                            separator,
                            InkWell(
                                onTap: _pickAddress,
                                child: AbsorbPointer(
                                  child: TextFormField(
                                      controller: _countryController,
                                      // enabled: false,
                                      autovalidateMode: _autovalidateCountry,
                                      textInputAction: TextInputAction.done,
                                      onChanged: _cubit.countryChanged,
                                      onEditingComplete: () {
                                        setState(() {
                                          _autovalidateCountry =
                                              AutovalidateMode.always;
                                        });
                                      },
                                      style: TextStyle(color: Colors.white),
                                      validator: (val) {
                                        return val!.isEmpty
                                            ? "country name must not be empty"
                                            : null;
                                      },
                                      decoration: formsWidget.formDecoration(
                                          'Country',
                                          icon: Icons.location_pin)),
                                )),
                            separator,
                            TextFormField(
                                textInputAction: TextInputAction.next,
                                focusNode: _passNode,
                                onChanged: _cubit.passwordChanged,
                                autofillHints: [
                                  AutofillHints.newPassword,
                                  AutofillHints.password
                                ],
                                onEditingComplete: () {
                                  setState(() {
                                    _autovalidatePass = AutovalidateMode.always;
                                  });
                                  _cPassNode.requestFocus();
                                },
                                autovalidateMode: _autovalidatePass,
                                obscureText: _isPasswordObscure,
                                // controller: _passwordController,
                                style: TextStyle(color: Colors.white),
                                validator: _cubit.passwordValidator,
                                decoration: formsWidget.formDecoration(
                                  'Password',
                                  icon: Icons.security,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                        _isPasswordObscure
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordObscure =
                                            !_isPasswordObscure;
                                      });
                                    },
                                  ),
                                )),
                            separator,
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              focusNode: _cPassNode,
                              onChanged: _cubit.confirmPasswordChanged,
                              autofillHints: [
                                AutofillHints.newPassword,
                                AutofillHints.password
                              ],
                              onEditingComplete: () {
                                setState(() {
                                  _autovalidateCPass = AutovalidateMode.always;
                                });
                                _cPassNode.unfocus();
                                setAutoValidate();
                              },
                              autovalidateMode: _autovalidateCPass,
                              obscureText: _isConfirmPasswordObscure,
                              // controller: _confirmPasswordController,
                              style: TextStyle(color: Colors.white),
                              validator: (pass) =>
                                  _cubit.confirmPasswordValidator(
                                      state.password ?? '', pass ?? ''),
                              decoration: formsWidget.formDecoration(
                                'Confirm Password',
                                icon: Icons.security,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      _isConfirmPasswordObscure
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      _isConfirmPasswordObscure =
                                          !_isConfirmPasswordObscure;
                                    });
                                  },
                                ),
                              ),
                            ),
                            separator,
                            // separator,
                            // Padding(
                            //     padding: const EdgeInsets.symmetric(
                            //         horizontal: Dimens.PADDING_SMALL),
                            //     child: PlacePicker(
                            //       color: Colors.white70,
                            //       label: 'Address',
                            //       onChanged: _cubit.addressChanged,
                            //       // useUnderline: true,
                            //     )),
                            // Padding(
                            //     padding: const EdgeInsets.symmetric(
                            //         horizontal: Dimens.PADDING_SMALL),
                            //     child: LocationForm(
                            //         cubit: _locationCubit,
                            //         spacer: SizedBox(
                            //           height: 10,
                            //         ))),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    signupButton(),
                  ],
                ))),
      );
  inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.elliptical(0, 0)),
      //borderRadius: BorderRadius.all(Radius.circular(22.0)),
      borderSide: const BorderSide(color: Colors.white, width: 0.0),
    );
  }

  Widget get separator => SizedBox(height: 20);

  setAutoValidate() {
    _autovalidateFName = AutovalidateMode.always;
    _autovalidateLName = AutovalidateMode.always;
    // _autovalidateUsername = AutovalidateMode.always;
    _autovalidateEmail = AutovalidateMode.always;
    _autovalidatePhone = AutovalidateMode.always;
    _autovalidatePass = AutovalidateMode.always;
    _autovalidateCPass = AutovalidateMode.always;
    _autovalidateStageName = AutovalidateMode.always;
    _autovalidateCity = AutovalidateMode.always;
    _autovalidateState = AutovalidateMode.always;
    _autovalidateCountry = AutovalidateMode.always;
  }

  _submit() {
    setAutoValidate();
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      _cubit.register(context);
    }
  }

  signupButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimens.PADDING_SMALL - 5,
            vertical: Dimens.PADDING_SMALL),
        child: BlocBuilder<LocationCubit, LocationState>(
            bloc: _locationCubit,
            builder: (context, state) => BlocBuilder<LoginCubit, LoginState>(
                bloc: _cubit,
                builder: (context, state) => formsWidget.wideButton(
                    'REGISTER', context, _submit,
                    isLoading: state.isLoading,
                    disable: !_cubit.signupValid || state.isLoading))));
  }

  Widget _login() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(Login.routeName);
      },
      child: Container(
          alignment: Alignment.center,
          child: Text.rich(
            TextSpan(children: [
              TextSpan(text: 'Already have an account ? '),
              TextSpan(
                  text: ' Login!',
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

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: ListView(children: <Widget>[
          SizedBox(height: 20),
          formsWidget.appIcon(),
          // formsWidget.sectionH1('Welcome'),
          formsWidget.sectionBody('Create Account', size: 20.0),
          SizedBox(height: 10),
          signupFields(),
          // login(),
          SizedBox(height: 10),
          _login(),
          SizedBox(height: 30),
        ]),
      ),
    );
  }
}
