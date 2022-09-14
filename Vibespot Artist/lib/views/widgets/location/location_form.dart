import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vsartist/models/country.dart';
import 'package:vsartist/models/state_city.dart';

import '../dropdown_input.dart';
import 'cubit/location_cubit.dart';

class LocationForm extends StatefulWidget {
  final LocationCubit cubit;
  final Widget spacer;
  final BoxDecoration? decoration;
  final bool showToplabel;
  const LocationForm(
      {Key? key, required this.cubit, this.spacer = const SizedBox(), this.decoration, this.showToplabel = false})
      : super(key: key);

  @override
  _LocationFormState createState() => _LocationFormState();
}

class _LocationFormState extends State<LocationForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: 600,
            child: BlocBuilder<LocationCubit, LocationState>(
                bloc: widget.cubit,
                builder: (context, state) => DropdownInput<Country>(
                        value: state.country,
                        hint: 'Country',
                        label: 'Country',
                        decoration: widget.decoration,
                        isLoading: state.isLoading,
                        prefix: Icon(Icons.location_on),
                        onTap: widget.cubit.getCountries,
                        showToplabel: widget.showToplabel,
                        onChanged: widget.cubit.countryChanged,
                        options: [
                          if (state.countries != null)
                            for (var _state in state.countries!)
                              InputItem(_state, _state.countryName)
                        ]))),
        widget.spacer,
        SizedBox(
            width: 600,
            child: BlocBuilder<LocationCubit, LocationState>(
                bloc: widget.cubit,
                builder: (context, state) => DropdownInput<StateCity>(
                        value: state.state,
                        hint: 'State',
                        label: 'State',
                        isLoading: state.isLoading,
                        showToplabel: widget.showToplabel,
                        decoration: widget.decoration,
                        prefix: Icon(Icons.location_city),
                        onTap: () => widget.cubit.getStates(state.country),
                        onChanged: widget.cubit.stateChanged,
                        options: [
                          if (state.states != null)
                            for (var _state in state.states!)
                              InputItem(_state, _state.stateName ?? '')
                        ]))),
        widget.spacer,
        SizedBox(
            width: 600,
            child: BlocBuilder<LocationCubit, LocationState>(
                bloc: widget.cubit,
                builder: (context, state) => DropdownInput<StateCity>(
                        value: state.city,
                        hint: 'City', 
                        label: 'City', 
                        decoration: widget.decoration,
                        showToplabel: widget.showToplabel,
                        isLoading: state.isLoading,
                        prefix: Icon(Icons.home),
                        onTap: () => widget.cubit.getCities(state.state),
                        onChanged: widget.cubit.cityChanged,
                        options: [
                          if (state.cities != null)
                            for (var _state in state.cities!)
                              InputItem(_state, _state.cityName ?? '')
                        ])))
      ],
    );
  }
}
