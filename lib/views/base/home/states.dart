import 'package:market_home/views/base/favourite/change_favorite.dart';

class HomeStates {}

class LoadingState extends HomeStates {}

class SuccessState extends HomeStates {}

class FailedState extends HomeStates {
  final String err;

  FailedState(this.err);
}

class ChangeFavLoading extends HomeStates {}

class ChangeFavSuccess extends HomeStates {
  final FavChangeModel model;

  ChangeFavSuccess(this.model);
}

class ChangeFavFailed extends HomeStates {}

class LoadingFavoriteState extends HomeStates {}

class SuccessFavoriteState extends HomeStates {}

class FailedFavoriteState extends HomeStates {}
