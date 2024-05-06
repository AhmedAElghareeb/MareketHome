import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_home/core/cache.dart';
import 'package:market_home/core/end_points.dart';
import 'package:market_home/services/dio.dart';
import 'package:market_home/views/base/home/model.dart';
import 'package:market_home/views/base/home/states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeStates());

  static HomeCubit get(context) => BlocProvider.of(context);

  HomeModel? homeModel;

  void getHomeData() {
    emit(LoadingState());

    DioHelper.i
        .getData(
      path: home,
      token: CachedData.getData(
        key: "token",
      ),
    )
        .then((value) {
      homeModel = HomeModel.fromJson(
        value.data,
      );
      emit(SuccessState());
    }).catchError((err) {
      emit(
        FailedState(err.toString()),
      );
    });
  }
}
