import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_home/core/end_points.dart';
import 'package:market_home/services/dio.dart';
import 'package:market_home/views/base/categories/model.dart';
import 'package:market_home/views/base/categories/states.dart';

class CategoriesCubit extends Cubit<CategoriesStates> {
  CategoriesCubit() : super(CategoriesStates());

  static CategoriesCubit get(context) => BlocProvider.of(context);

  CategoriesModel? categoriesModel;

  void getCategories() {
    emit(LoadingState());

    DioHelper.i
        .getData(
      path: categories,
    )
        .then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(SuccessState());
    }).catchError((err) {
      emit(
        FailedState(err.toString()),
      );
    });
  }
}
