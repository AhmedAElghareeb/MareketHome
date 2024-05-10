class SettingsModel {
  late final bool status;
  late final SettingsDataModel data;

  SettingsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? false;
    data = SettingsDataModel.fromJson(json['data'] ?? {});
  }
}

class SettingsDataModel {
  late final String about;
  late final String terms;

  SettingsDataModel.fromJson(Map<String, dynamic> json) {
    about = json['about'] ?? "";
    terms = json['terms'] ?? "";
  }
}
