// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:market_home/core/cache.dart';
// import 'package:market_home/core/end_points.dart';
// import 'package:market_home/core/helper.dart';
// import 'package:market_home/services/dio.dart';
// import 'package:market_home/views/base/favourite/change_favorite.dart';
// import 'package:market_home/views/base/favourite/states.dart';
//
// class FavoritesCubit extends Cubit<FavoritesStates> {
//   FavoritesCubit() : super(FavoritesStates());
//
//   static FavoritesCubit get(context) => BlocProvider.of(context);
//
//   FavChangeModel? model;
//
//
// void changeFavorites({required int id}) {
//   DioHelper.i
//       .postData(
//     path: favourites,
//     data: {
//       "product_id": id,
//     },
//     token: CachedData.getData(
//       key: "token",
//     ),
//   )
//       .then((value) {
//     model = FavChangeModel.fromJson(value.data);
//
//     FlashHelper.showToast(value.data['message'], type: MessageType.success);
//
//     emit(AddFavSuccessState());
//   }).catchError((err) {
//     FlashHelper.showToast(err.data['message']);
//     emit(
//       AddFavFailedState(
//         err.toString(),
//       ),
//     );
//   });
// }
// }