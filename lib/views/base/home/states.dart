class HomeStates {}

class LoadingState extends HomeStates {}

class SuccessState extends HomeStates {}

class FailedState extends HomeStates {
  final String err;

  FailedState(this.err);
}

class FavoritesState extends HomeStates {}

class FavoritesSuccessState extends HomeStates {}

class FavoritesFailedState extends HomeStates {
  final String err;

  FavoritesFailedState(this.err);
}
