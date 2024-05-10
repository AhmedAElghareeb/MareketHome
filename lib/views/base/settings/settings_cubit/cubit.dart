import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_home/core/end_points.dart';
import 'package:market_home/services/dio.dart';
import 'package:market_home/views/base/settings/settings_cubit/model.dart';

part 'states.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit() : super(SettingsStates());

  static SettingsCubit get(context) => BlocProvider.of(context);

  SettingsModel? model;

  void getData() {
    emit(LoadingSettingsState());

    DioHelper.i
        .getData(
      path: settings,
    ).then((value) {
      model = SettingsModel.fromJson(value.data);
      emit(SuccessSettingsState());
    }).catchError((err) {
      emit(FailedSettingsState());
    });
  }
}
