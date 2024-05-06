class HomeStates {}

class LoadingState extends HomeStates {}

class SuccessState extends HomeStates {}

class FailedState extends HomeStates {
  final String err;

  FailedState(this.err);
}
