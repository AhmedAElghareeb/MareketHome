import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_home/core/end_points.dart';
import 'package:market_home/core/widgets.dart';
import 'package:market_home/services/dio.dart';
import 'package:market_home/views/base/favourite/change_favorite.dart';
import 'package:market_home/views/base/favourite/model.dart';
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
      token: token,
    )
        .then((value) {
      homeModel = HomeModel.fromJson(
        value.data,
      );
      homeModel!.data.products.forEach((element) {
        fav.addAll({
          element.id: element.inFavourite,
        });
      });
      emit(SuccessState());
    }).catchError((err) {
      emit(
        FailedState(err.toString()),
      );
    });
  }

  FavChangeModel? favChangeModel;

  Map<int, bool> fav = {};

  void addToFavorites({required int id}) {
    fav[id] = !fav[id]!;
    emit(ChangeFavLoading());
    DioHelper.i
        .postData(
      path: favourites,
      data: {
        "product_id": id,
      },
      token: token,
    )
        .then((value) {
      favChangeModel = FavChangeModel.fromJson(value.data);

      if (!favChangeModel!.status) {
        fav[id] = !fav[id]!;
      } else
      {
        getFavData();
      }
      emit(ChangeFavSuccess(
        favChangeModel!
      ));
    }).catchError((err) {
      fav[id] = !fav[id]!;
      emit(ChangeFavFailed());
    });
  }

  FavoritesModel? model;

  void getFavData() {
    emit(LoadingFavoriteState());

    DioHelper.i
        .getData(
      path: favourites,
      token: token,
    )
        .then((value) {
      model = FavoritesModel.fromJson(value.data);
      emit(SuccessFavoriteState());
    }).catchError((err) {
      emit(FailedFavoriteState());
    });
  }
}
