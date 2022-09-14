import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vsartist/constants/app_colors.dart';
import 'package:vsartist/constants/dimens.dart';
import 'package:vsartist/core/router/app_route.dart';
import 'package:vsartist/views/account/bloc/auth/auth_bloc.dart';
import 'package:vsartist/views/account/cubit/login_cubit.dart';
import 'package:vsartist/views/upload/image_upload.dart';
import 'package:vsartist/views/widgets/place/address.dart';
import 'package:vsartist/views/widgets/place/autocomplete_screen.dart';
import 'package:vsartist/views/widgets/cached_image.dart';
import 'package:vsartist/views/widgets/forms.dart';
import 'package:vsartist/views/widgets/location/cubit/location_cubit.dart';
import 'package:vsartist/views/widgets/location/location_form.dart';
import 'package:vsartist/views/widgets/place/place_picker.dart';

class ProfileScreen extends StatefulWidget implements AppRoute {
  @override
  String get routeNam => routeName;

  static String get routeName => 'profile';

  @override
  Widget get page => this;
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late LoginCubit _cubit;
  // late LocationCubit _locationCubit;
  FormsWidget formsWidget = FormsWidget();
  FocusNode _cityNode = FocusNode();
  FocusNode _stateNode = FocusNode();
  FocusNode _countryNode = FocusNode();
  FocusNode _phoneNode = FocusNode();
  FocusNode _youtubeNode = FocusNode();
  FocusNode _fNameNode = FocusNode();
  FocusNode _lNameNode = FocusNode();
  FocusNode _stageNameNode = FocusNode();

  AutovalidateMode _autovalidateFName = AutovalidateMode.disabled;
  AutovalidateMode _autovalidateLName = AutovalidateMode.disabled;
  AutovalidateMode _autovalidateCity = AutovalidateMode.disabled;
  AutovalidateMode _autovalidateState = AutovalidateMode.disabled;
  AutovalidateMode _autovalidateCountry = AutovalidateMode.disabled;
  AutovalidateMode _autovalidateEmail = AutovalidateMode.disabled;
  AutovalidateMode _autovalidatePhone = AutovalidateMode.disabled;
  AutovalidateMode _autovalidateStageName = AutovalidateMode.disabled;
  AutovalidateMode _autovalidateYoutubeName = AutovalidateMode.disabled;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController _fNameController = TextEditingController();
  TextEditingController _lNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _sNameController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _youtubeController = TextEditingController();

  @override
  void initState() {
    // LoginRepository().getProfile();
    // _locationCubit = LocationCubit();
    var usr = Auth.state.user;
    _cubit = LoginCubit()
      ..firstnameChanged(usr?.firstname ?? '')
      ..lastnameChanged(usr?.surname ?? '')
      ..emailChanged(usr?.email ?? '')
      ..cityChanged(usr?.city ?? '')
      ..stateChanged(usr?.state ?? '')
      ..countryChanged(usr?.country ?? '')
      ..phoneChanged(usr?.phone ?? '');
    if (usr?.country != null || usr?.city != null || usr?.state != null)
      _cubit.addressChanged(Address(
        city: usr!.city ?? '',
        country: usr.country ?? '',
        state: usr.state ?? '',
      ));

    _fNameController.text = usr?.firstname ?? '';
    _lNameController.text = usr?.surname ?? '';
    _sNameController.text = usr?.stageName ?? '';
    _emailController.text = usr?.email ?? '';
    _cityController.text = usr?.city ?? '';
    _stateController.text = usr?.state ?? '';
    _countryController.text = usr?.country ?? '';
    _phoneController.text = usr?.phone ?? '';
    _youtubeController.text = usr?.youtubeChannel ?? '';

    super.initState();
    LoginRepository().getProfile();
  }

  @override
  void dispose() {
    _cubit.close();
    // _locationCubit.close();
    super.dispose();
    LoginRepository().getProfile();
  }

  Widget get separator => SizedBox(height: 10);

  formDecoration(String title, {IconData? icon, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: title,
      labelText: title,
      hintStyle: TextStyle(color: Colors.grey[400]),
      // labelStyle: TextStyle(color:  AppColors.PRIMARY),
      // isDense: true,
      suffixIcon: suffixIcon,
      contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      // fillColor: Colors.white,
      enabledBorder: const UnderlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: const BorderSide(color: AppColors.PRIMARY, width: 1.0),
      ),
      disabledBorder: const UnderlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: .50),
      ),
      border: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
    );
  }

  _buildImage(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
              aspectRatio: 16 / 9,
              // height: 250,
              // width: MediaQuery.of(context).size.width,
              child: CachedImage(
                  fit: BoxFit.cover, url: Auth.state.user?.artistImage ?? '')),
          BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 5),
              child: Material(
                  shape: CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CachedImage(
                      fit: BoxFit.cover,
                      url: Auth.state.user?.artistImage ?? '',
                    ),
                  ))),
          Positioned(
              right: 20,
              bottom: 20,
              child: ImageUpload(
                  displayOnlyView: true,
                  upload: (path) => _cubit.uploadImage(context, path),
                  view: FloatingActionButton(
                    backgroundColor: AppColors.PRIMARY,
                    // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    mini: true,
                    onPressed: null,
                    child: Icon(
                      Icons.file_upload_outlined,
                      color: Colors.white,
                    ),
                  )))
        ],
      );

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CupertinoNavigationBar(
            backgroundColor: Theme.of(context).backgroundColor,
            middle: Text(
              'Profile',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          body: Column(
            children: [
              _buildImage(context),
              Expanded(
                child: Material(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.PADDING_SMALL),
                    child: AutofillGroup(
                      child: Form(
                          key: formKey,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 5),
                              child: BlocBuilder<LoginCubit, LoginState>(
                                bloc: _cubit,
                                builder: (context, state) => ListView(
                                  shrinkWrap: true,
                                  children: [
                                    SizedBox(height: 40),
                                    TextFormField(
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      autovalidateMode: _autovalidateEmail,
                                      // focusNode: _emailNode,
                                      enabled: false,
                                      onChanged: _cubit.emailChanged,
                                      // autofillHints: [AutofillHints.email],
                                      onEditingComplete: () {
                                        setState(() {
                                          _autovalidateEmail =
                                              AutovalidateMode.always;
                                        });
                                        _phoneNode.requestFocus();
                                      },
                                      style: TextStyle(color: Colors.white),
                                      validator: _cubit.emailValidator,
                                      decoration: formDecoration('Email',
                                          icon: Icons.email),
                                    ),
                                    separator,
                                    TextFormField(
                                        controller: _fNameController,
                                        autovalidateMode: _autovalidateFName,
                                        focusNode: _fNameNode,
                                        onChanged: _cubit.firstnameChanged,
                                        textInputAction: TextInputAction.next,
                                        autofillHints: [
                                          AutofillHints.givenName
                                        ],
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
                                        decoration: formDecoration(
                                          'First name',
                                          // icon: Icons.account_circle
                                        )),
                                    separator,
                                    TextFormField(
                                        controller: _lNameController,
                                        autovalidateMode: _autovalidateLName,
                                        focusNode: _lNameNode,
                                        textInputAction: TextInputAction.next,
                                        onChanged: _cubit.lastnameChanged,
                                        autofillHints: [
                                          AutofillHints.familyName
                                        ],
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
                                        decoration: formDecoration('Last name',
                                            icon: Icons.account_circle)),
                                    separator,
                                    TextFormField(
                                        controller: _sNameController,
                                        focusNode: _stageNameNode,
                                        onChanged: _cubit.stageNameChanged,
                                        textInputAction: TextInputAction.next,
                                        autovalidateMode:
                                            _autovalidateStageName,
                                        autofillHints: [
                                          AutofillHints.newUsername
                                        ],
                                        onEditingComplete: () {
                                          setState(() {
                                            _autovalidateStageName =
                                                AutovalidateMode.always;
                                          });
                                          _youtubeNode.requestFocus();
                                        },
                                        style: TextStyle(color: Colors.white),
                                        validator: (val) {
                                          return val!.length < 4
                                              ? "Stage name must have at least 4 chars"
                                              : null;
                                        },
                                        decoration: formDecoration('Stage name',
                                            icon: Icons.person)),
                                    separator,
                                    TextFormField(
                                        controller: _youtubeController,
                                        focusNode: _youtubeNode,
                                        onChanged: _cubit.youtubeChanged,
                                        textInputAction: TextInputAction.next,
                                        autovalidateMode: _autovalidateYoutubeName,
                                        autofillHints: [
                                          AutofillHints.newUsername
                                        ],
                                        onEditingComplete: () {
                                          setState(() {
                                            _autovalidateYoutubeName = AutovalidateMode.always;
                                          });
                                          _phoneNode.requestFocus();
                                        },
                                        style: TextStyle(color: Colors.white),
                                        decoration: formDecoration('Youtube channel name',
                                            icon: Icons.person)),
                                    separator,
                                    TextFormField(
                                        textInputAction: TextInputAction.next,
                                        controller: _phoneController,
                                        keyboardType: TextInputType.phone,
                                        autovalidateMode: _autovalidatePhone,
                                        focusNode: _phoneNode,
                                        onChanged: _cubit.phoneChanged,
                                        autofillHints: [
                                          AutofillHints.telephoneNumber
                                        ],
                                        onEditingComplete: () {
                                          setState(() {
                                            _autovalidatePhone =
                                                AutovalidateMode.always;
                                          });
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
                                        decoration: formDecoration(
                                            'Phone Number',
                                            icon: Icons.phone)),
                                    separator,
                                    InkWell(
                                      onTap: _pickAddress,
                                      child: TextFormField(
                                          enabled: false,
                                          controller: _countryController,
                                          focusNode: _countryNode,
                                          onChanged: _cubit.countryChanged,
                                          textInputAction: TextInputAction.next,
                                          autovalidateMode:
                                              _autovalidateCountry,
                                          onEditingComplete: () {
                                            setState(() {
                                              _autovalidateCountry =
                                                  AutovalidateMode.always;
                                            });
                                            _stateNode.requestFocus();
                                          },
                                          style: TextStyle(color: Colors.white),
                                          // validator: (val) {
                                          //   return val!.length < 4
                                          //       ? "Stage name must have at least 4 chars"
                                          //       : null;
                                          // },
                                          decoration: formDecoration('Country ',
                                              icon: Icons.person)),
                                    ),
                                    separator,
                                    InkWell(
                                      onTap: _pickAddress,
                                      child: TextFormField(
                                          enabled: false,
                                          controller: _stateController,
                                          focusNode: _stateNode,
                                          onChanged: _cubit.stateChanged,
                                          textInputAction: TextInputAction.next,
                                          autovalidateMode: _autovalidateState,
                                          onEditingComplete: () {
                                            setState(() {
                                              _autovalidateState =
                                                  AutovalidateMode.always;
                                            });
                                            _stateNode.requestFocus();
                                          },
                                          style: TextStyle(color: Colors.white),
                                          // validator: (val) {
                                          //   return val!.length < 4
                                          //       ? "Stage name must have at least 4 chars"
                                          //       : null;
                                          // },
                                          decoration: formDecoration('State ',
                                              icon: Icons.person)),
                                    ),
                                    separator,
                                    InkWell(
                                      onTap: _pickAddress,
                                      child: TextFormField(
                                          enabled: false,
                                          controller: _cityController,
                                          focusNode: _cityNode,
                                          onChanged: _cubit.cityChanged,
                                          textInputAction: TextInputAction.done,
                                          autovalidateMode: _autovalidateCity,
                                          onEditingComplete: () {
                                            setState(() {
                                              _autovalidateCity =
                                                  AutovalidateMode.always;
                                            });
                                            // _stateNode.requestFocus();
                                          },
                                          style: TextStyle(color: Colors.white),
                                          // validator: (val) {
                                          //   return val!.length < 4
                                          //       ? "Stage name must have at least 4 chars"
                                          //       : null;
                                          // },
                                          decoration: formDecoration('City ',
                                              icon: Icons.person)),
                                    ),

                                    SizedBox(height: 10),
                                    // Padding(
                                    //     padding: const EdgeInsets.symmetric(
                                    //         horizontal: Dimens.PADDING_SMALL),
                                    //     child: PlacePicker(
                                    //       color: Colors.white70,
                                    //       label: 'Address',
                                    //       address: state.address,
                                    //       onChanged: _cubit.addressChanged,
                                    //       useUnderline: true,
                                    //     )),
                                    // separator,
                                    // Padding(
                                    //     padding: const EdgeInsets.symmetric(
                                    //         horizontal: Dimens.PADDING_SMALL),
                                    //     child: LocationForm(
                                    //         showToplabel: true,
                                    //         decoration: BoxDecoration(
                                    //             border: Border(
                                    //                 bottom: BorderSide(
                                    //                     color: Colors.white, width: .7))),
                                    //         cubit: _locationCubit,
                                    //         spacer: SizedBox(
                                    //           height: 10,
                                    //         ))),
                                    SizedBox(height: 50),
                                    _updateButton,
                                    SizedBox(height: 50),
                                  ],
                                ),
                              ))),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  setAutoValidate() {
    _autovalidateFName = AutovalidateMode.always;
    _autovalidateLName = AutovalidateMode.always;
    _autovalidateCity = AutovalidateMode.always;
    _autovalidateState = AutovalidateMode.always;
    _autovalidateCountry = AutovalidateMode.always;
    _autovalidateEmail = AutovalidateMode.always;
    _autovalidatePhone = AutovalidateMode.always;
    _autovalidateStageName = AutovalidateMode.always;
  }

  _submit() {
    setAutoValidate();
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      _cubit.updateProfile(context, Auth.state.user?.artistImage);
    }
  }

  Widget get _updateButton {
    return BlocBuilder<LoginCubit, LoginState>(
        bloc: _cubit,
        builder: (context, state) => Padding(
            padding: const EdgeInsets.all(24.0),
            child: formsWidget.wideButton('Update', context, _submit,
                isLoading: state.isLoading,
                disable: !_cubit.profileValid || state.isLoading)));
  }
}
