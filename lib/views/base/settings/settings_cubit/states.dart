part of 'cubit.dart';

class SettingsStates {}

class LoadingSettingsState extends SettingsStates {}

class SuccessSettingsState extends SettingsStates {}

class FailedSettingsState extends SettingsStates {}

class LoadingFaqsState extends SettingsStates {}

class SuccessFaqsState extends SettingsStates {}

class FailedFaqsState extends SettingsStates {}

class LoadingComplaintsState extends SettingsStates {}

class SuccessComplaintsState extends SettingsStates
{
  final ComplaintsModel model;

  SuccessComplaintsState(this.model);
}

class FailedComplaintsState extends SettingsStates {}
