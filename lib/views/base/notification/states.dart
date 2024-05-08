class NotificationsStates {}

class LoadingState extends NotificationsStates {}
class SuccessState extends NotificationsStates {}
class FailedState extends NotificationsStates
{
  final String err;

  FailedState(this.err);
}