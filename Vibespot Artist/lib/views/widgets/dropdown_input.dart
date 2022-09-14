import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vsartist/constants/app_colors.dart';

class DropdownInput<T> extends StatelessWidget {
  final FocusNode? focusNode;
  final T? value;
  final Function(T?)? onChanged;
  final Function(T)? done;
  final Function()? onTap;
  final String? label;
  final String? hint;
  final String? errorText;
  final bool showToplabel;
  final List<InputItem<T>>? options;
  final BoxDecoration? decoration;
  final TextStyle? style;
  final TextStyle? textStyle;
  final Color? textColor;
  final bool isDense;
  final Widget? prefix;
  final bool isLoading, enabled;
  final Widget? suffix;
  final Size? iconSize;
  final String? Function(T?)? validator;
  final EdgeInsets? horizontalPadding;
  DropdownInput(
      {Key? key,
      this.focusNode,
      this.value,
      this.onChanged,
      this.label,
      this.options,
      this.decoration,
      this.showToplabel = true,
      this.style,
      this.textStyle,
      this.isDense = false,
      this.enabled = true,
      this.iconSize,
      this.horizontalPadding,
      this.prefix,
      this.errorText,
      this.textColor,
      this.suffix,
      this.hint,
      this.done,
      this.isLoading = false,
      this.onTap,
      this.validator})
      : super(key: key);
  // T v;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: !(options != null && options!.length > 0 && !isLoading)
              ? onTap
              : () {
                  // if (Platform.isAndroid) return;
                  if (enabled) {
                    _select(context);
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Cannot edit $label')));
                  }
                },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showToplabel)
                Padding(
                  padding: const EdgeInsets.only(left: .0, bottom: 2),
                  child: Text(label ?? '',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.white54)),
                ),
              Container(
                margin: EdgeInsets.only(top: showToplabel ? 0 : 10),
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: showToplabel ? 0 : 4,
                ),
                decoration: decoration ??
                    BoxDecoration(
                        // color: AppColors.PRIMARY.withOpacity(.03),
                        borderRadius: BorderRadius.circular(0),
                        border: Border.all(color: Colors.white, width: .3)),
                child: AbsorbPointer(
                  absorbing: true,
                  child: DropdownButton<T>(
                      dropdownColor: AppColors.BACKGROUND_COLOR,
                      itemHeight: kMinInteractiveDimension,
                      // onTap: () => _select(context),
                      // iconSize: 30,
                      icon: isLoading
                          ? Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: CupertinoActivityIndicator(),
                            )
                          : suffix ??
                              Icon(Icons.keyboard_arrow_down_rounded,
                                  color: AppColors.PRIMARY),
                      underline: SizedBox.shrink(),
                      focusNode: focusNode,
                      value: value,
                      hint: Padding(
                          padding: EdgeInsets.only(
                            bottom: 5,
                            top: 5,
                            // left: LayoutUtils.computeSize(context, large: 24),
                          ),
                          child: Row(
                            children: [
                              // if (prefix != null) prefix!,
                              Text(
                                hint ?? label!,
                                style: style ??
                                    Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                          color: Colors.white54,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                              ),
                            ],
                          )),
                      isExpanded: true,
                      isDense: isDense,
                      items: [
                        for (var option in options!)
                          DropdownMenuItem(
                            value: option.value,
                            child: Row(
                              children: [
                                // if (prefix != null)
                                //   Padding(
                                //     padding: const EdgeInsets.only(right: 8.0),
                                //     child: prefix!,
                                //   ),
                                Text(option.title,
                                    style: textStyle ??
                                        Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            )),
                              ],
                            ),
                          )
                      ],
                      onChanged: onChanged),
                ),
              ),
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
        // if (value != null && showToplabel ||
        //     (validator != null && validator!(value) != null))
        //   Positioned(
        //     left: 50,
        //     child: Container(
        //       padding: EdgeInsets.symmetric(horizontal: 8.0),
        //       // color: Colors.white,
        //       child: Text(label ?? (validator != null ? validator!(value) : ''),
        //           style: Theme.of(context).textTheme.bodyText1!.copyWith(
        //               fontWeight: FontWeight.bold,
        //               fontSize: 9,
        //               color: Color(0xff283461))),
        //     ),
        //   )
      ],
    );
  }

  Future _select(
    BuildContext context,
  ) async {
    T val = value ?? options![0].value;

    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: Colors.black,
      builder: (c) => SizedBox(
        height: 300,
        child: Theme(
          data: ThemeData.dark().copyWith(
            cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
                textTheme: CupertinoTextThemeData(
              textStyle: TextStyle(color: Colors.white, fontSize: 12),
            )),
            brightness: Brightness.dark,
          ),
          child: Column(
            children: [
              Container(
                color: Colors.black,
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                    // textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(c).pop();
                    },
                    child: Text('Done')),
              ),
              Divider(height: 2, thickness: 1, color: AppColors.PRIMARY),
              Expanded(
                child: CupertinoPicker.builder(
                    scrollController: FixedExtentScrollController(
                        initialItem:
                            options!.indexWhere((v) => v.value == value)),
                    onSelectedItemChanged: (i) {
                      onChanged!(options![i].value);
                      val = options![i].value;
                    },
                    itemExtent: 25,
                    diameterRatio: 2,
                    magnification: 1.3,
                    backgroundColor: CupertinoColors.black,
                    useMagnifier: true,
                    squeeze: .7,
                    childCount: options?.length ?? 0,
                    itemBuilder: (c, i) => Center(
                          child: Text(options![i].title,
                              style: style?.copyWith(
                                  // color: Color(0xff283461),
                                  fontSize: 12,
                                  color: Colors.white,
                                  //     // decorationColor: Colors.white,
                                  backgroundColor: Colors.white,
                                  fontWeight: FontWeight.w400)),
                        )),
              ),
            ],
          ),
        ),
      ),
    ).then((value) {
      if (done != null) done!(val);
    });
  }
}

class InputItem<T> {
  final T value;
  final String title;

  InputItem(this.value, this.title);
}
