class LoginModel {
  late final bool status;
  late final String message;

  late final UserData data;

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json["status"] ?? false;
    message = json["message"] ?? "";
    data = UserData.fromJson(
      json['data'] ?? {},
    );
  }
}

class UserData {
  late final int id;
  late final String name;
  late final String email;
  late final String phone;
  late final String image;
  late final int point;
  late final int credit;
  late final String token;

  UserData.fromJson(Map<String, dynamic> json) {
    id = json["id"] ?? 0;
    name = json["name"] ?? "";
    email = json["email"] ?? "";
    phone = json["phone"] ?? "";
    image = json["image"] ?? "";
    point = json["points"] ?? 0;
    credit = json["credit"] ?? 0;
    token = json["token"] ?? "";
  }
}
