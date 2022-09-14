import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'base_refresher.dart';

/// base class for views that uses a refresh indicator, without refresher list bloc
abstract class ListRefresher<W extends StatefulWidget, T>
    extends BaseRefresher<W, BuiltList<T>> {
      final RefreshController _refreshController = RefreshController();
  RefreshController get refreshController => _refreshController;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) => _isLoading = value;

  /// if true pullUp is enabled
  bool get enablePullUp => canLoadMore ?? false;
  bool? canLoadMore;

  /// data with which to populate the body
  BuiltList<T>? get data;

  /// message to display when there is an error
  String? get message;
  int get length => data?.length ?? 0;

  /// load data
  void load({bool invalidateCache = false, bool overrideTime = false});
}
