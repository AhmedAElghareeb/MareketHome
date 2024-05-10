import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_home/core/end_points.dart';
import 'package:market_home/core/widgets.dart';
import 'package:market_home/services/dio.dart';
import 'package:market_home/views/base/notification/model.dart';
import 'package:market_home/views/base/notification/states.dart';

class NotificationsCubit extends Cubit<NotificationsStates> {
  NotificationsCubit() : super(NotificationsStates());

  static NotificationsCubit get(context) => BlocProvider.of(context);

  NotificationsModel? model;
  void getData() {
    emit(LoadingState());

    DioHelper.i
        .getData(
      path: notifications,
      token: token,
    )
        .then((value) {
          model = NotificationsModel.fromJson(value.data);
      emit(
        SuccessState(),
      );
    }).catchError((err) {
      emit(FailedState(err.toString()));
    });
  }
}
