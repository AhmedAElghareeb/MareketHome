import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_home/core/cache.dart';
import 'package:market_home/core/end_points.dart';
import 'package:market_home/services/dio.dart';
import 'package:market_home/views/base/favourite/change_favorite.dart';
import 'package:market_home/views/base/home/model.dart';
import 'package:market_home/views/base/home/states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeStates());

  static HomeCubit get(context) => BlocProvider.of(context);

  HomeModel? homeModel;

  FavChangeModel? model;

  Map<int, bool> favorites = {};

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
      for (var element in homeModel!.data.products) {
        favorites.addAll({
          element.id: element.inFavourite,
        });
      }
      emit(SuccessState());
    }).catchError((err) {
      emit(
        FailedState(err.toString()),
      );
    });
  }

  void changeFavorites(int id) {
    favorites[id] = !favorites[id]!;
    emit(FavoritesState());

    DioHelper.i
        .postData(
      path: favourites,
      data: {
        "product_id": id,
      },
      token: CachedData.getData(
        key: "token",
      ),
    )
        .then((value) {
      model = FavChangeModel.fromJson(value.data);

      if(model!.status == false)
      {
        favorites[id] = !favorites[id]!;
      }
      emit(FavoritesSuccessState());
    }).catchError((err) {
      favorites[id] = !favorites[id]!;
      emit(
        FavoritesFailedState(
          err.toString(),
        ),
      );
    });
  }
}
