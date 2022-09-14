part of 'location_cubit.dart';

class LocationState extends Equatable with UtilsMixin {
  final String? token;
  final StateCity?  state, city;
  final BuiltList<Country>? countries;
  final Country? country;
  final bool isLoading;
  final BuiltList<StateCity>? states, cities;

  bool get hasValidToken => !isJWTExpired(token ?? '');

  LocationState(
      {this.isLoading = false,
      this.token,
      this.state,
      this.city,
      this.countries,
      this.country,
      this.states,
      this.cities});

  LocationState copyWith(
          {String? token,
          StateCity? state,
          StateCity? city,
          bool? isLoading,
          BuiltList<Country>? countries,
          Country? country,
          BuiltList<StateCity>? states,
          BuiltList<StateCity>? cities}) =>
      LocationState(
          token: token ?? this.token,
          state: state ?? this.state,
          isLoading: isLoading ?? false,
          city: city ?? this.city,
          countries: countries ?? this.countries,
          country: country ?? this.country,
          states: states ?? this.states,
          cities: cities ?? this.cities);

  LocationState countriesUpdate(BuiltList<Country> countries) =>
      LocationState(
        token: this.token,
        countries: countries,
      );
        LocationState countryChanged(Country country) =>
      LocationState(
        token: this.token,
        countries: countries,
        country: country
      );


  LocationState statesUpdate(BuiltList<StateCity> states) => LocationState(
      token: this.token, country: country, countries: this.countries, states: states);

       LocationState stateChanged(StateCity state) => LocationState(
      token: this.token, country: country, countries: this.countries, states: states, state: state);

  LocationState citiesUpdate(BuiltList<StateCity> cities) => LocationState(
      token: this.token,
      countries: this.countries,
      states: states,
      country: country,
      state: state,
      cities: cities);

  @override
  List<Object?> get props =>
      [token, state, city, states, cities, countries, country, isLoading];

  @override
  String toString() => {
        token: token,
        state: state,
        city: city,
        countries: countries,
        country: country,
        states: states,
        cities: cities
      }.toString();
}
