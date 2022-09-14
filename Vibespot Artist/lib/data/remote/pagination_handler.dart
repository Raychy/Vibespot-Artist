import 'package:built_collection/built_collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vsartist/constants/strings.dart';
import 'package:vsartist/core/utils/exception_formater.dart';
import 'package:vsartist/models/error_model.dart';
import 'package:vsartist/views/widgets/refresh/base_bloc.dart'; 

import 'provider/api_response.dart';

mixin PaginationHandlerMixin on ExceptionFormater {
  Future<void> loadData({bool loadMore, String? id, Map<String, dynamic>? query});

  /// resolve response or error and dispatchs an event accordingly
  Future<void> handleRespone<InnerType>(Bloc bloc, ApiResponse response,
      {bool? isMore,
      String? message,
      String? errorMessage,
      bool invertData = false}) async {
    if (response.body != null && response.body is BuiltList<InnerType>) {
      var pagination = response.pagination;
      print('page ---- $isMore');
      var data = response.body as BuiltList<InnerType>?;
      bloc.add(UpdateDataListEvent<InnerType>(
        invertData ? data!.reversed.toBuiltList() : data!,
        isMore ?? false,
        // total: pagination?.totalCount,
        // chunkCount: pagination?.chunkCount,
        // limit: pagination?.limit,
        // pages: pagination?.pageCount,
        // page: pagination?.page ?? 1,
        // order: pagination?.order,
        // query: pagination?.query,
      ));
      // if (message != null) AppDialog.snakbar(message ?? '');
    } else if (response.body != null && response.body is InnerType) {
      var data = response.body as InnerType;
      bloc.add(UpdateDataEvent<InnerType>(data));
    } else {
      bloc.add(LoadFailed<InnerType>((response.error as ErrorModel?)?.message ??
          Strings.DEFAULT_ERROR_MESSAGE));
    }
  }
}
