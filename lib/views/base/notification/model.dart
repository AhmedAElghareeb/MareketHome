class NotificationsModel {
  late final bool status;
  late final NotificationsDataModel data;

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? false;
    data = NotificationsDataModel.fromJson(json['data'] ?? {});
  }
}

class NotificationsDataModel {
  late final int currentPage;
  late final List<DataModel> list;

  NotificationsDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'] ?? 0;
    list = List.from(json['data'] ?? [])
        .map(
          (e) => DataModel.fromJson(
            (e),
          ),
        )
        .toList();
  }
}

class DataModel {
  late final int id;
  late final String title;
  late final String message;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    title = json['title'] ?? "";
    message = json['message'] ?? "";
  }
}
