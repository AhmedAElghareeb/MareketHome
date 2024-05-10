class ComplaintsModel {
  late final bool status;
  late final String message;

  ComplaintsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? false;
    message = json['message'] ?? "";
  }
}
