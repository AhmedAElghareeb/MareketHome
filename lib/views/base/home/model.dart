class HomeModel {
  late final bool status;
  late final HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'] ?? false;
    data = HomeDataModel.fromJson(json['data']);
  }

}

class HomeDataModel {

  late final List<BannerModel> banners;
  late final List<ProductsModel> products;

  HomeDataModel.fromJson(Map<String, dynamic> json)
  {
    banners = List.from(json['banners'] ?? []).map((e) => BannerModel.fromJson(e)).toList();
    products = List.from(json['products'] ?? []).map((e) => ProductsModel.fromJson(e)).toList();
  }

}

class BannerModel {

  late final int id;
  late final String image;

  BannerModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'] ?? 0;
    image = json['image'] ?? "";
  }
}

class ProductsModel {
  late final int id;
  late final dynamic price;
  late final dynamic oldPrice;
  late final dynamic discount;
  late final String image;
  late final String name;
  late final bool inFavourite;
  late final bool inCart;

  ProductsModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'] ?? 0;
    price = json['price'] ?? 0;
    oldPrice = json['old_price'] ?? 0;
    discount = json['discount'] ?? 0;
    image = json['image'] ?? "";
    name = json['name'] ?? "";
    inFavourite = json['in_favorites'] ?? false;
    inCart = json['in_cart'] ?? false;
  }
}