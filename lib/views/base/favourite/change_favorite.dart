class FavChangeModel
{
  late final bool status;
  late final String message;

  FavChangeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? false;
    message = json['message'] ?? "";
  }
}