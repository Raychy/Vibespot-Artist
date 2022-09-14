import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vsartist/core/extensions/context.dart';

class OtpForm extends StatefulWidget {
  final int count;
  final double space;
  final Function(String) onChanged;
  final String otp;
  final bool encrypted;
  final TextInputType? inputType;
  final List<TextInputFormatter> formaters;
  const OtpForm({
    Key? key,
    this.space = 0.0,
    required this.onChanged,
    this.count = 4,
    this.otp = '',
    this.encrypted = false,
    this.formaters = const [],
    this.inputType = TextInputType.number,
  }) : super(key: key);
  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  late FocusNode _focusNode;
  late TextEditingController _controller;

  @override
  void initState() {
    _focusNode = FocusNode();
    _controller = TextEditingController();
    _controller.text = widget.otp;
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  update(String text) {
    text = text.replaceAll(' ', '');

    text = text.substring(0, min(widget.count, text.length));
    widget.onChanged(text);
    if (text.length == widget.count) {
      WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
    }
  }

  String getOtpItem(int index) {
    if ((widget.otp.length) > index) return widget.otp[index];
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onLongPress: () async {
            var data = await Clipboard.getData("text/plain");
            if (data?.text?.isNotEmpty ?? false) {
              var text = data!.text!.trim();
              if (text.length == 6) {
                _controller.text = text;
                update(text);
              }
            }
          },
          onTap: _focusNode.requestFocus,
          child: SizedBox(
            height: 90,
            child: Stack(children: [
              AutofillGroup(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  enabled: true,
                  autofillHints: const <String>[AutofillHints.oneTimeCode],
                  autofocus: false,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(widget.count),
                    ...widget.formaters
                  ],
                  autocorrect: false,
                  onChanged: update,

                  keyboardType: widget.inputType ?? TextInputType.text,
                  // enableInteractiveSelection: false,
                  // showCursor: false,
                  maxLength: widget.count,
                  buildCounter: (c,
                          {int? currentLength,
                          bool? isFocused,
                          int? maxLength}) =>
                      Text(''),
                  cursorWidth: 0.01,

                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    border: InputBorder.none,
                    fillColor: Colors.transparent,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  style: const TextStyle(
                    color: Colors.transparent,
                    height: .01,
                    fontSize:
                        0.01, // it is a hidden textfield which should remain transparent and extremely small
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (var i = 0; i < widget.count; i++)
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(widget.space),
                        child: OtpChip(
                            encrypted: widget.encrypted,
                            number: getOtpItem(i),
                            isFocused: _focusNode.hasFocus &&
                                (widget.otp.length == i ||
                                    (i == widget.count - 1 &&
                                        widget.otp.length == widget.count))),
                      )),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

class OtpChip extends StatelessWidget {
  final bool encrypted;
  final String number;
  final bool isFocused;

  const OtpChip(
      {Key? key,
      this.number = '',
      this.isFocused = false,
      this.encrypted = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var inputTheme = Theme.of(context).inputDecorationTheme;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: AspectRatio(
        aspectRatio: .85,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: isFocused ? context.primaryColor : Colors.transparent),
              borderRadius: BorderRadius.circular(6),
              color: isFocused
                  ? Colors.transparent
                  // : (context.isDark
                      : const Color(0xFF332F2F)
                      // : const Color(0xffE3E3E3)) //inputTheme.fillColor,
              ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: SizedBox(
                // height: 80,
                child: Center(
                    child: Text(
              encrypted ? (number.isNotEmpty ? '•' : '') : number,
              style: Theme.of(context).textTheme.headline4!.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 24, color: Colors.white
              ),
            ))),
          ),
        ),
      ),
    );
  }
}
