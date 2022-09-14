import 'package:flutter/material.dart';

import 'address.dart';
import 'autocomplete_screen.dart';

class PlacePicker extends StatefulWidget {
  final Address? address;
  final String label, hint;
  final Color? color;
  final bool useUnderline;
  final BoxDecoration? decoration;
  final Function(Address) onChanged;
  final String Function(Address?)? customDisplay;
  const PlacePicker(
      {Key? key,
      this.address,
      required this.onChanged,
      this.label = 'Address',
      this.hint = 'Click to enter address',
      this.decoration,
      this.color,
      this.useUnderline = false, this.customDisplay})
      : super(key: key);

  @override
  _PlacePickerState createState() => _PlacePickerState();
}

class _PlacePickerState extends State<PlacePicker> {
  Address? address;

  @override
  void initState() {
    address = widget.address;
    super.initState();
  }

  void _pickAddress() async {
    var data = await showDialog(
        context: context, builder: (c) => AutocompleteScreen());

    if (data is Address) {
      address = data;
      setState(() {});

      widget.onChanged(address!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(left: 15.0, bottom: 6),
        //   child: Text(widget.label,
        //       maxLines: 1,
        //       overflow: TextOverflow.ellipsis,
        //       style: Theme.of(context).textTheme.bodyText1!.copyWith(
        //           fontWeight: FontWeight.w400,
        //           fontSize: 1,
        //           color: Colors.white54)),
        // ),
        Container(
          width: 600,
          decoration: widget.decoration ??
              BoxDecoration(
                  // color: AppColors.PRIMARY.withOpacity(.03),
                  borderRadius: BorderRadius.circular(0),
                  border: Border.all(
                      color: widget.useUnderline
                          ? Colors.transparent
                          : Colors.white,
                      width: .3)),
          child: InkWell(
            onTap: _pickAddress,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: widget.useUnderline ? 6 : 20,
                  vertical: widget.useUnderline ? 10 : 15),
              child: Text(widget.customDisplay != null ?widget.customDisplay!(address): address?.place ?? widget.hint,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: widget.color)),
            ),
          ),
        ),
        if (widget.useUnderline)
          Container(
            color: Colors.white,
            height: .6,
          )
      ],
    );
  }
}
