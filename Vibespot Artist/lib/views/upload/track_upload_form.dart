import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vsartist/constants/dimens.dart';
import 'package:vsartist/constants/genre.dart';
import 'package:vsartist/models/album.dart';
import 'package:vsartist/models/release.dart';
import 'package:vsartist/views/upload/audio_upload.dart';
import 'package:vsartist/views/upload/image_upload.dart';
import 'package:vsartist/views/widgets/common-scaffold.dart';
import 'package:vsartist/views/widgets/date_input_field.dart';
import 'package:vsartist/views/widgets/dropdown_input.dart';
import 'package:vsartist/views/widgets/forms.dart';
import 'package:vsartist/views/widgets/location/cubit/location_cubit.dart';
import 'package:vsartist/views/widgets/location/location_form.dart';
import 'package:vsartist/views/widgets/multiple_text_field.dart';
import 'package:vsartist/views/widgets/place/place_picker.dart';

import '../../global_variables.dart';
import 'cubit/track_cubit.dart';

class TrackUploadForm extends StatefulWidget {
  final Album? album;
  final Release? release;
  final Function()? reloadList;
  final Widget? navigateTo;
  final int count, position, total;

  const TrackUploadForm(
      {Key? key,
      this.album,
      this.release,
      this.navigateTo,
      this.reloadList,
      this.count = 1,
      this.position = 1,
      this.total = 1})
      : super(key: key);

  @override
  _TrackUploadFormState createState() => _TrackUploadFormState();
}

class _TrackUploadFormState extends State<TrackUploadForm> {
  FormsWidget formsWidget = FormsWidget();
  final scaffoldState = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TrackCubit _cubit;
  late LocationCubit _locationCubit;
  final TextEditingController _controller = TextEditingController();

  String releaseNameTooltip =
      'This is used to identify the upload of tracks and it is not seen by your listener';

  var uploadDate = DateTime.now();

  @override
  void initState() {
    _cubit = TrackCubit();
    _locationCubit = LocationCubit();
    if (widget.release != null) {
      _cubit.titleChanged(widget.release?.releaseName ?? '');
    }
    super.initState();
  }

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  dispose() {
    _cubit.close();
    _locationCubit.close();
    super.dispose();
  }

  _submit() {
    autovalidateMode = AutovalidateMode.onUserInteraction;
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      _cubit
          .createTrack(context, _locationCubit.state,
              navigateTo: widget.navigateTo,
              reloadList: widget.reloadList,
              albumId: widget.album?.id,
              releaseId: widget.release?.id,
              total: widget.total,
              position: widget.position,
              count: widget.count)
          .then((value) =>
              widget.reloadList != null ? widget.reloadList!() : null);
    }
  }

  @override
  Widget build(BuildContext context) {
    var genre = GENRE.toList();
    var payment = PAYMENT.toList();
    genre.sort((a, b) => a.compareTo(b));
    return ScaffoldCommon(
      // scaffoldState: scaffoldState,
      appTitle: 'Upload Track ${widget.position} / ${widget.total}',
      bodyData: Theme(
        data: ThemeData(primarySwatch: Colors.orange),
        child: BlocBuilder<TrackCubit, TrackState>(
            bloc: _cubit,
            builder: (context, state) => SafeArea(
                  child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimens.PADDING_SMALL),
                        child: ListView(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 30.0),
                              // Text('Track ${widget.count}'),
                              // formsWidget.sectionHeader('Release details'),
                              // SizedBox(height: 15.0),
                              if (widget.release == null)
                                SizedBox(height: 20.0),
                              if (widget.release == null)
                                formsWidget.textFieldHeader(
                                    context, 'Track title'),
                              if (widget.release == null) SizedBox(height: 4.0),
                              if (widget.release == null)
                                formsWidget.textInput(
                                    'track title', _cubit.titleChanged,
                                    autovalidateMode: autovalidateMode),
                              SizedBox(height: 20.0),

                              DropdownInput<String>(
                                key: ValueKey('Genre'),
                                label: 'Genre',
                                hint: 'Genre',
                                value: state.genre,
                                onChanged: _cubit.genreChanged,
                                errorText: autovalidateMode ==
                                            AutovalidateMode
                                                .onUserInteraction &&
                                        state.genre == null
                                    ? 'Please select genre '
                                    : null,
                                options: [
                                  // if (state.genre == null ||
                                  //     state.genre!.isEmpty)
                                  //   InputItem('Choose Genre', 'Genre'),
                                  for (var item in genre) InputItem(item, item)
                                ],
                              ),
                              SizedBox(height: 20.0),
                              // DropdownInput<String>(
                              //   key: ValueKey('Payment'),
                              //   label: 'Payment',
                              //   hint: 'Payment',
                              //   value: state.payment,
                              //   onChanged: _cubit.paymentChanged,
                              //   errorText: autovalidateMode ==
                              //               AutovalidateMode
                              //                   .onUserInteraction &&
                              //           state.payment == null
                              //       ? 'select payment type'
                              //       : null,
                              //   options: [
                              //     for (var item in payment)
                              //       InputItem(item, item)
                              //   ],
                              // ),
                              // SizedBox(height: 20.0),
                              // state.payment =="Paid" ? formsWidget.textFieldHeader(context, 'Price') : SizedBox(),
                              // state.payment =="Paid" ? SizedBox(height: 4.0) : SizedBox(),
                              // state.payment =="Paid" ? TextFormField(
                              //   controller: _controller,
                              //   enabled: true,
                              //   keyboardType: TextInputType.number,
                              //   decoration: new InputDecoration(
                              //     focusedBorder: OutlineInputBorder(
                              //       borderSide: BorderSide(color: Colors.white.withOpacity(0.4)),
                              //     ),
                              //     enabledBorder: OutlineInputBorder(
                              //       borderSide: BorderSide(color: Colors.white.withOpacity(0.4)),
                              //     ),
                              //     hintText: 'Price',
                              //     hintStyle: TextStyle(color: Colors.grey)
                              //   ),
                              //   autovalidateMode: autovalidateMode,
                              //   onChanged:(val){
                              //     setState(() {
                              //       songUploadPrice.value = int.parse(_controller.text);
                              //       print(songUploadPrice.value);
                              //     });
                              //   },
                              //   style: TextStyle(color: Colors.white),
                              //   validator: (val) {
                              //     return val!.length < 1
                              //         ? "This cannot be empty"
                              //         : null;
                              //   },
                              // ) : SizedBox(),
                              // state.payment =="Paid" ? SizedBox(height: 20.0) : SizedBox(),

                              formsWidget.textFieldHeader(
                                  context, 'Featuring by'),
                              SizedBox(height: 4.0),
                              // formsWidget.textInput(
                              //     'Featuring By', _cubit.featuringByChanged,
                              //     autovalidateMode: autovalidateMode),
                              MultipleTextField(
                                key: ValueKey('Featuring-by'),
                                value: state.producedBy?.split(',').toSet(),
                                onChanged: (value) => _cubit.producedByChanged(
                                    value.length > 0
                                        ? value.reduce((value, element) =>
                                            '$value, $element')
                                        : ''),
                              ),
                              SizedBox(height: 20.0),
                              formsWidget.textFieldHeader(
                                  context, 'Produced By'),
                              SizedBox(height: 4.0),
                              // formsWidget.textInput(
                              //     'Produced By', _cubit.producedByChanged,
                              //     autovalidateMode: autovalidateMode),
                              // SizedBox(height: 20.0),
                              MultipleTextField(
                                key: ValueKey('produced-by'),
                                value: state.producedBy?.split(',').toSet(),
                                onChanged: (value) => _cubit.producedByChanged(
                                    value.length > 0
                                        ? value.reduce((value, element) =>
                                            '$value, $element')
                                        : ''),
                              ),
                              // SizedBox(
                              //   width: 600,
                              //   child: DateInputField(
                              //     key: ValueKey('release-date'),
                              //     margin: EdgeInsets.symmetric(),
                              //     minimumYear: DateTime.now().year,
                              //     firstDate: DateTime.now(),
                              //     maximumYear: DateTime.now().year + 100,
                              //     showLabel: true,
                              //     label: 'Proposed Release Date',
                              //     value: state.releaseDate,
                              //     onChanged: _cubit.releaseDateChanged,
                              //     errorText: autovalidateMode ==
                              //                 AutovalidateMode
                              //                     .onUserInteraction &&
                              //             state.releaseDate == null
                              //         ? 'Please enter valid release date'
                              //         : null,
                              //   ),
                              // ),
                              SizedBox(height: 20.0),
                              if (widget.release != null)
                                formsWidget.textFieldHeader(
                                    context, 'State Vibes'),
                              if (widget.release != null) SizedBox(height: 4.0),
                              if (widget.release != null)
                                PlacePicker(
                                    color: Colors.white70,
                                    label: 'State Vibes',
                                    hint: 'Click to enter location ',
                                    address: state.sateVibes,
                                    onChanged: _cubit.sateVibesChanged,
                                    customDisplay: (address) {
                                      if (address == null)
                                        return 'Click to enter location';
                                      return '${address.state}, ${address.country}';
                                    }
                                    // useUnderline: true,
                                    ),
                              // if (widget.release != null)
                              // if (widget.release != null)
                              SizedBox(height: 20.0),
                              // if (widget.release != null)
                              formsWidget.textFieldHeader(
                                  context, 'Delivery/Push Locations'),
                              if (widget.release != null) SizedBox(height: 4.0),
                              // if (widget.release != null)
                              if (widget.release != null)
                                PlacePicker(
                                  color: Colors.white70,
                                  label: 'Delivery/Push Locations',
                                  hint: 'Click to enter location',
                                  address: state.pushLocation,
                                  onChanged: _cubit.pushLocationChanged,
                                  // useUnderline: true,
                                ),
                              SizedBox(height: 20.0),
                              // LocationForm(
                              //     showToplabel: true,
                              //     cubit: _locationCubit,
                              //     spacer: SizedBox(height: 10)),
                              // SizedBox(height: 20.0),
                              AudioUpload(cubit: _cubit),
                              SizedBox(height: 20.0),
                              // if (widget.release != null)
                              // ImageUpload(cubit: _cubit),
                              SizedBox(height: 50.0),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: formsWidget.wideButton(
                                      'NEXT',
                                      context,
                                      state.formValid //&&
                                          // (widget.album != null ||
                                          //     state.image != null)
                                          ? _submit
                                          : null,
                                      isLoading: state.isLoading)),
                              SizedBox(height: 50.0),
                            ]),
                      )),
                )),
      ),
      showDrawer: false,
    );
  }
}
