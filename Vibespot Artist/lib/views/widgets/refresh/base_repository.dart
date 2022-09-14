import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

typedef Future<T> NetworkCall<T>();

/// base class for managing api calls
abstract class BaseRepository   {
  // DataProvider? dataProvider;
  final Bloc bloc;

  BaseRepository(this.bloc);

  // void dispose() => dataProvider?.dispose();

  Future<void> loadData({bool loadMore, String id});
 
}

// class Pagination {
//   final int total;
//   final int pages;
//   final int page;

//   Pagination(this.total, this.pages, this.page);
// }
