class FaqsModel
{
  late final bool status;
  late final FaqsData data;

  FaqsModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'] ?? false;
    data = FaqsData.fromJson(json['data'] ?? {});
  }
}

class FaqsData
{
  late final int currentPage;
  late final List<FaqsDataModel> list;

  FaqsData.fromJson(Map<String, dynamic> json)
  {
    currentPage = json['current_page'] ?? 0;
    list = List.from(json['data'] ?? []).map((e) => FaqsDataModel.fromJson(e)).toList();
  }
}

class FaqsDataModel
{
  late final int id;
  late final String question;
  late final String answer;

  FaqsDataModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'] ?? 0;
    question = json['question'] ?? "";
    answer = json['answer'] ?? "";
  }
}