import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_home/core/end_points.dart';
import 'package:market_home/core/widgets.dart';
import 'package:market_home/services/dio.dart';
import 'package:market_home/views/base/search/model.dart';
import 'package:market_home/views/base/search/states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchStates());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void searchData({
    required String text,
  }) {
    emit(LoadingSearchState());

    DioHelper.i.postData(
      path: search,
      token: token,
      data: {
        "text": text,
      },
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SuccessSearchState());
    }).catchError((err) {
      emit(FailedSearchState());
    });
  }
}
