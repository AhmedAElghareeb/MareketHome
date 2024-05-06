class CategoriesStates {}

class LoadingState extends CategoriesStates {}

class SuccessState extends CategoriesStates {}

class FailedState extends CategoriesStates
{
  final String err;

  FailedState(this.err);
}
