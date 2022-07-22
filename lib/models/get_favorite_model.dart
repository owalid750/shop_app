import 'package:shop_app/models/home_model.dart';

class FavoriteModel {
  late  bool status;

  late  FavoriteDataModel data;

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    data = FavoriteDataModel.fromJson(json['data']);
  }
}

class FavoriteDataModel {
  late  int currentPage;
  late  List<FavoritesData> data;

  FavoriteDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];

    data = <FavoritesData>[];
    json['data'].forEach((v) {
      data.add(FavoritesData.fromJson(v));
    });
  }
}

class FavoritesData {
   int? id;
  late ProductModel product;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = ProductModel.fromJson(json['product']);
  }
}
