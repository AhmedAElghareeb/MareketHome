class CategoriesModel
{
  late final bool status;
  late final CategoriesData data;

  CategoriesModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'] ?? false;
    data = CategoriesData.fromJson(json['data']);
  }
}

class CategoriesData
{
  late final int currentPage;
  late final List<CategoriesDataModel> list;
  
  CategoriesData.fromJson(Map<String, dynamic> json) 
  {
    currentPage = json['current_page'] ?? 0;
    list = List.from(json['data'] ?? []).map((e) => CategoriesDataModel.fromJson(e)).toList();
  }
}

class CategoriesDataModel
{
  late final int id;
  late final String name;
  late final String image;

  CategoriesDataModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    image = json['image'] ?? "";
  }

}