import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'base_bloc.dart';
import 'refresher_bloc.dart';
import 'refresher_list_bloc.dart';

/// base class for views that uses a refresh indicator
abstract class BaseRefresher<W extends StatefulWidget, T> extends State<W> {
  // BaseBloc bloc;
  ScrollController? scrollController;
  RefreshController get refreshController;

  bool get isLoading;

  /// if true pull up is enabled
  bool get enablePullUp;

  /// data with which to populate the body
  T? get data;

  // BaseState get state => bloc.state;

  /// message to display when there is an error
  String? get message;
  int get length;

  /// load data
  void loadData([bool loadMore]);

  /// wrap the body with a smart refresher
  Widget buildBody(
    BuildContext context, {
    required Widget child,
    bool allowNull = false,
    Widget? loadingIndicator,
    bool allowRefresh = true,
  }) =>
      SmartRefresher(
          enablePullDown: allowRefresh,
          enablePullUp: enablePullUp,
          scrollController: scrollController,
          primary: scrollController == null,
          footer: ClassicFooter(
              height: 100,
              loadingIcon: CupertinoActivityIndicator(),
              loadingText: 'loading more.....',
              completeDuration: Duration(milliseconds: 800)),
          header: ClassicHeader(
            refreshStyle: RefreshStyle.Follow,
            completeText: '',
            failedText: '',
            refreshingIcon: CupertinoActivityIndicator(),
            completeDuration: Duration(milliseconds: 800),
          ),
          onLoading: () => loadData(true),
          onRefresh: loadData,
          controller: refreshController,
          child: data != null && length > 0
              ? child
              : isLoading
                  ? loadingIndicator ??
                      Center(child: CupertinoActivityIndicator())
                  : allowNull
                      ? child
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Icon(CupertinoIcons.doc_text_search,
                                  size: 70),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Text(message ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14)),
                            ),
                          ],
                        ));
}

/// base class for views that uses a refresh indicator, but uses a refresher list bloc
abstract class BaseListRefresher<W extends StatefulWidget, T>
    extends BaseRefresher<W, BuiltList<T>> {
  late RefresherListBloc<T>? bloc;
  RefreshController get refreshController =>
      bloc?.refreshController ?? RefreshController();

  bool get isLoading => state?.isLoading ?? false;

  /// if true pull up is enabled
  bool get enablePullUp => canLoadMore ?? state?.hasNext ?? false;
  bool? canLoadMore;

  /// data with which to populate the body
  BuiltList<T>? get data => state?.data;

  BaseListState<T>? get state => bloc?.state;

  /// message to display when there is an error
  String? get message => state?.message;
  int get length => state?.data?.length ?? 0;

  /// load data
  void loadData([bool loadMore = false]);
}

/// base class for views that uses a refresh indicator, but uses a refresher list bloc
/// [W] is a stateful widget, [T] is the data type
abstract class BaseRefresherDefault<W extends StatefulWidget, T>
    extends BaseRefresher<W, T> {
  RefresherBloc<T>? bloc;
  final _refreshController = RefreshController();
  RefreshController get refreshController =>
      bloc?.refreshController ?? _refreshController;

  bool get isLoading => state?.isLoading ?? false;

  /// if true pull up is enabled
  bool get enablePullUp => false;

  /// data with which to populate the body
  T? get data => state?.data;

  BaseDefaultState<T>? get state => bloc?.state;

  /// message to display when there is an error
  String? get message => state?.message;

  int get length => data != null ? 1 : 0;

  /// load data
  void loadData([bool loadMore]);
}
