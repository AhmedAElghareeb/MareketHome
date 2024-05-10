class SearchModel
{
  late final bool status;
  late final DataModel data;

  SearchModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'] ?? false;
    data = DataModel.fromJson(json['data'] ?? {});
  }
}

class DataModel
{
  late final int currentPage;
  late final List<SearchDataModel> list;

  DataModel.fromJson(Map<String, dynamic> json)
  {
    currentPage = json['current_page'] ?? 0;
    list = List.from(json['data'] ?? []).map((e) => SearchDataModel.fromJson(e)).toList();
  }
}

class SearchDataModel
{
  late final int id;
  late final dynamic price;
  late final String image;
  late final String name;

  late final String description;
  late final bool inFav;
  late final bool inCart;

  SearchDataModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'] ?? 0;
    price = json['price'] ?? 0;
    image = json['image'] ?? "";
    name = json['name'] ?? "";
    description = json['description'] ?? "";
    inFav = json['in_favorites'] ?? false;
    inCart = json['in_cart'] ?? false;
  }
}