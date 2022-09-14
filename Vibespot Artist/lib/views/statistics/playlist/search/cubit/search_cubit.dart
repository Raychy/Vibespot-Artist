import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<String> {
  SearchCubit() : super('');

  queryChanged(String query) => emit(query);
}
