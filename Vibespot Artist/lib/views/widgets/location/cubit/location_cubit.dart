import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:vsartist/core/env.dart';
import 'package:vsartist/core/utils/utils_mixin.dart';
import 'package:vsartist/data/data_repository.dart';
import 'package:vsartist/data/local/local_repository.dart';
import 'package:vsartist/data/remote/api_services/location_api_service.dart';
import 'package:vsartist/data/remote/provider/api_response.dart';
import 'package:vsartist/models/country.dart';
import 'package:vsartist/models/state_city.dart';

part 'location_state.dart';
part 'location_repository.dart';

class LocationCubit extends Cubit<LocationState> {
  var env = GetIt.I<Env>();
  LocationCubit() : super(LocationState()) {
    getCountries();
  }

  LocationRepository _repository = LocationRepository();

  Future<void> getToken() async {
    emit(state.copyWith(isLoading: true));
    var response =
        await _repository.getToken(env.locationApiEmail, env.locationApiToken);

    if (response.isSuccessful && response.body != null) {
      emit(state.copyWith(token: response.body));
    }
    emit(state.copyWith());
  }

  Future<void> getCountries() async {
    if (!state.hasValidToken) {
      await getToken();
      return getCountries();
    }
    emit(state.copyWith(isLoading: true));
    var response = await _repository.getCountries(state.token ?? '');

    if (response.isSuccessful && response.body != null) {
      // print(response.body);
      emit(state.countriesUpdate(response.body!));
    }
    emit(state.copyWith());
  }

  Future<void> getStates(Country? country) async {
    if (country == null) return;
    if (!state.hasValidToken) {
      await getToken();
      return getStates(country);
    }
    emit(state.copyWith(isLoading: true));
    var response =
        await _repository.getStates(state.token ?? '', country.countryName);

    if (response.isSuccessful && response.body != null) {
      print(response.body);
      emit(state.statesUpdate(response.body!));
    }
    emit(state.copyWith());
  }

  Future<void> getCities(StateCity? s) async {
    if (s == null) return;
    if (!state.hasValidToken) {
      await getToken();
      return getCities(s);
    }
    emit(state.copyWith(isLoading: true));
    var response =
        await _repository.getCities(state.token ?? '', s.stateName ?? '');

    if (response.isSuccessful && response.body != null) {
      print(response.body);
      emit(state.citiesUpdate(response.body!));
    }
    emit(state.copyWith());
  }

  void countryChanged(Country? country) {
    if (country == null) return;
    emit(state.countryChanged(country));
    Future.delayed(Duration(milliseconds: 500), () {
      if (country == state.country) getStates(country);
    });
  }

  void stateChanged(StateCity? s) {
    if (s == null) return;
    emit(state.stateChanged(s));
    Future.delayed(Duration(milliseconds: 500), () {
      if (s == state.state) getCities(s);
    });
  }

  void cityChanged(StateCity? s) {
    if (s == null) return;
    emit(state.copyWith(city: s));
  }
  bool isNotEmpty(String? value) => value != null && value.isNotEmpty;

  bool get locationValid =>
      state.country != null && state.state != null && state.city != null;
}
