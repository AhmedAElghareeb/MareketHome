class FavoritesModel
{
  late final bool status;
  late final FavData data;

  FavoritesModel.fromJson(Map<String, dynamic> json) 
  {
    status = json['status'] ?? false;
    data = FavData.fromJson(json['data'] ?? {});
  }
}

class FavData
{
  late final int currentPage;
  late final List<FavDataModel> list;

  FavData.fromJson(Map<String, dynamic> json) 
  {
    currentPage = json['current_page'] ?? 0;
    list = List.from(json['data'] ?? []).map((e) => FavDataModel.fromJson((e))).toList();
  }
}

class FavDataModel 
{
  late final int id;
  late final Product product;

  FavDataModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'] ?? 0;
    product = Product.fromJson(json['product'] ?? {});
  }
}

class Product
{
  late final int id;
  late final dynamic price;
  late final dynamic oldPrice;
  late final dynamic discount;
  late final String image;
  late final String name;
  late final String description;

  Product.fromJson(Map<String, dynamic> json)
  {
    id = json['id'] ?? 0;
    price = json['price'] ?? 0;
    oldPrice = json['old_price'] ?? 0;
    discount = json['discount'] ?? 0;
    image = json['image'] ?? "";
    name = json['name'] ?? "";
    description = json['description'] ?? "";
  }
}