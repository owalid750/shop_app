class HomeModel {
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? HomeDataModel.fromJson(json['data']) : null;
  }
}

class HomeDataModel {
  List<BannerModel>? banners;
  List<ProductModel>? products;

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <BannerModel>[];
      json['banners'].forEach((element) {
        banners!.add(BannerModel.fromJson(element));
      });
    }
    if (json['products'] != null) {
      products = <ProductModel>[];
      json['products'].forEach((element) {
        products!.add(ProductModel.fromJson(element));
      });
    }
  }
}

class BannerModel {
  int? id;
  String? img;
  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['image'];
  }
}

class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? img;
  String? name;
  bool? inFavourite;
  bool? inCart;
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    img = json['image'];
    name = json['name'];
    inFavourite = json['in_favorites'];
    inCart = json['in_cart'];
  }
}


