import 'package:vsartist/constants/app_colors.dart';
import 'package:vsartist/constants/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vsartist/core/extensions/index.dart';
import 'package:vsartist/core/theme/app_theme.dart';

class DateInputField extends StatelessWidget {
  final FocusNode? focusNode;
  final DateTime? value;
  final int? maximumYear, minimumYear;
  final Function(DateTime date) onChanged;
  final String label;
  final bool showLabel;
  final bool showIcon, enabled;
  final String? errorText;
  final DateTime? firstDate, lastDate;
  final EdgeInsets? margin, padding;
  const DateInputField({
    Key? key,
    this.focusNode,
    this.value,
    required this.onChanged,
    this.label = '',
    this.showLabel = true, this.enabled = true,
    this.margin,
    this.padding,
    this.showIcon = true,
    this.maximumYear,
    this.minimumYear,
    this.firstDate,
    this.lastDate,
    this.errorText,
    // this.options
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding:
              margin ?? EdgeInsets.symmetric(horizontal: Dimens.PADDING_SMALL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showLabel)
                Padding(
                  padding: const EdgeInsets.only(left: .0, bottom: 06),
                  child: Text(label,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.white54)),
                ),
              Container(
                  // margin: showLabel ? EdgeInsets.only(top: 0) : null,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1),
                      border: Border.all(color: Colors.white, width: .3)),
                  child: InkWell(
                    onTap: () {
                      // !Platform.isAndroid
                      // ? _pickDateAlt(context)
                     
                        if (enabled) {
                      _pickDate(context);
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Cannot edit $label')));
                  }
                    },
                    child: Padding(
                      padding: padding ??
                          EdgeInsets.only(
                              left: 24.0.width,
                              right: 21.0.width,
                              bottom: 10,
                              top: 10),
                      child: Row(
                        children: [
                          Text(
                            value?.readableFormat ?? label,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: .1,
                                    fontSize: 14.0,
                                    color: Colors.white
                                        .withOpacity(value != null ? 1 : .5)),
                          ),
                          Spacer(),
                          if (showIcon)
                            SizedBox(
                                child: IconTheme(
                                    data: IconTheme.of(context),
                                    child: Icon(Icons.calendar_today,
                                        color: Colors.white)))
                        ],
                      ),
                    ),
                  )),
              if (errorText != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10),
                    child: Text(
                      errorText ?? '',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: AppColors.ERROR,
                          letterSpacing: .1,
                          height: .8,
                          fontSize: 12),
                    ),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _pickDateAlt(BuildContext context) async {
    WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
    var _firstDate = firstDate ?? DateTime(minimumYear ?? 1920);

    showDialog(
        context: context,
        builder: (c) => Theme(
              data: AppTheme.dark.copyWith(
                  colorScheme: ColorScheme.dark(primary: AppColors.PRIMARY),
                  primaryColorBrightness: Brightness.light,
                  brightness: Brightness.light,
                  dialogTheme: DialogTheme.of(context).copyWith(
                    backgroundColor: Colors.black,
                  )),
              child: DatePickerDialog(
                selectableDayPredicate: (d) {
                  print(d);
                  onChanged(d);
                  return true;
                },
                restorationId: 'date-dbb',
                currentDate: DateTime.now(),
                // currentDate: value,
                firstDate: _firstDate,
                initialDate: _firstDate.isBefore(value ?? DateTime.now())
                    ? (value ?? _firstDate)
                    : _firstDate,
                lastDate: lastDate ??
                    DateTime(maximumYear ?? (DateTime.now().year + 100)),
              ),
            ));
  }

  Future<void> _pickDate(BuildContext context) async {
    WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
    var _firstDate = firstDate ?? DateTime(minimumYear ?? 1920);
    if (value == null) onChanged(_firstDate);
    await showModalBottomSheet(
        context: context,
        // backgroundColor: Colors.white,
        builder: (c) => SizedBox(
            height: 300.0,
            child: Column(
              children: [
                Container(
                  color: CupertinoColors.black,
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(TextStyle(
                              color: AppColors.PRIMARY,
                              fontWeight: FontWeight.bold))),
                      // textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Done')),
                ),
                Divider(
                  height: .1,
                ),
                Expanded(
                    child: CupertinoTheme(
                  data: CupertinoTheme.of(context).copyWith(
                      textTheme: CupertinoTheme.of(context).textTheme.copyWith(
                          dateTimePickerTextStyle: CupertinoTheme.of(context)
                              .textTheme
                              .dateTimePickerTextStyle
                              .copyWith(color: Colors.white))),
                  child: CupertinoDatePicker(
                    backgroundColor: CupertinoColors.black,
                    onDateTimeChanged: onChanged,
                    maximumYear: maximumYear,
                    // minimumYear: min((value ?? DateTime.now()).year, (minimumYear ?? 1955)),
                    mode: CupertinoDatePickerMode.date,
                    //  selectionOverlay: Container(
                    //   decoration: BoxDecoration(
                    //       border: Border(
                    //     top: BorderSide(width: .05),
                    //     bottom: BorderSide(width: .05),
                    //   )),
                    // ),
                    maximumDate:
                        DateTime(maximumYear ?? (DateTime.now().year + 50)),
                    initialDateTime: value ?? DateTime.now(),
                  ),
                )),
              ],
            )));
  }
}
