import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_home/core/end_points.dart';
import 'package:market_home/services/dio.dart';
import 'package:market_home/views/base/settings/settings_cubit/complaints_model.dart';
import 'package:market_home/views/base/settings/settings_cubit/faqs_model.dart';
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
    )
        .then((value) {
      model = SettingsModel.fromJson(value.data);
      emit(SuccessSettingsState());
    }).catchError((err) {
      emit(FailedSettingsState());
    });
  }

  FaqsModel? faqsModel;

  void getFaqsData() {
    emit(LoadingFaqsState());
    DioHelper.i
        .getData(
      path: faqs,
    )
        .then((value) {
      faqsModel = FaqsModel.fromJson(value.data);
      emit(SuccessFaqsState());
    }).catchError((err) {
      emit(FailedFaqsState());
    });
  }

  ComplaintsModel? complaintsModel;

  void sendComplaints({
    required String name,
    required String phone,
    required String mail,
    required String msg,
  }) {
    emit(LoadingComplaintsState());

    DioHelper.i.postData(
      path: complaints,
      data: {
        "name": name,
        "phone": phone,
        "email": mail,
        "message": msg,
      },
    ).then((value) {
      complaintsModel = ComplaintsModel.fromJson(value.data);
      emit(SuccessComplaintsState(complaintsModel!));
    }).catchError((err) {
      emit(FailedComplaintsState());
    });
  }
}
