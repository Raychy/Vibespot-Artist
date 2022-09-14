import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vsartist/constants/api_urls.dart';
import 'package:vsartist/constants/app_colors.dart';
import 'package:vsartist/core/router/app_route.dart';
import 'package:vsartist/models/song.dart'; 
import 'package:vsartist/views/statistics/track/bloc/track_bloc.dart';
import 'package:vsartist/views/statistics/track/track_list.dart';
import 'package:vsartist/views/widgets/refresh/base_bloc.dart';

import 'cubit/search_cubit.dart';
import 'search_bar.dart';

class SearchScreen extends StatefulWidget implements AppRoute {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  String get routeNam => routeName;

  static String get routeName => 'search';

  @override
  Widget get page => this;
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchCubit cubit;
  late TrackBloc _bloc;
  late Map<String, dynamic> query;
  FocusNode focusNode = FocusNode();

  _reload(String q) {
    query = {'q': q};
    _bloc.add(LoadDataEvent<Song>(loadMore: false, query: query));
  }

  @override
  void initState() {
    cubit = SearchCubit();
    query = {'q': ''};
    _bloc = TrackBloc(ApiUrls.VIBESTREAM_SEARCH);
    super.initState();
    focusNode.requestFocus();
  }

  @override
  void dispose() {
    cubit.close();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchCubit, String>(
      bloc: cubit,
      listener: (context, state) {
        _reload(state);
      },
      child: Stack(children: [
        Material(
            child: BlocProvider(
                create: (context) => cubit,
                child: Scaffold(
                    backgroundColor: Theme.of(context).backgroundColor,
                    body: SafeArea(
                        child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Row(
                            children: [
                              SizedBox(width: 30),
                              Expanded(
                                  child: Hero(tag: ValueKey('searchBar'),
                                    child: SearchBar(
                                                                  focusNode: focusNode,
                                                                  cubit: cubit,
                                                                  // onPressed: () =>
                                                                  //     Navigator.of(context).pushNamed(SearchScreen.routeName),
                                                                ),
                                  )),
                              CloseButton(
                                color: AppColors.PRIMARY,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TrackList(
                            queryBuilder: () => query,
                            bloc: _bloc,
                            mode: TrackListMode.search,
                          ),
                        ),
                      ],
                    )))))
      ]),
    );
  }
}
