// class SearchModel {
//  late  bool status;
 
// late   SearchData data;

  

//   SearchModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
   
//     data = SearchData.fromJson(json['data']) ;
//   }
 
// }

// class SearchData {
// late  int currentPage;
//   late List<ProductData> data;
// //   late String firstPageUrl;
// //   late int? from;
// //   late int? lastPage;
// //  late String? lastPageUrl;
// //   Null? nextPageUrl;
// //   String? path;
// //   int? perPage;
// //   Null? prevPageUrl;
// //   int? to;
// //   int? total;

  
//   SearchData.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
   
//       data = <ProductData>[];
//       json['data'].forEach((v) {
//         data.add( ProductData.fromJson(v));
//       });
    
//     // firstPageUrl = json['first_page_url'];
//     // from = json['from'];
//     // lastPage = json['last_page'];
//     // lastPageUrl = json['last_page_url'];
//     // nextPageUrl = json['next_page_url'];
//     // path = json['path'];
//     // perPage = json['per_page'];
//     // prevPageUrl = json['prev_page_url'];
//     // to = json['to'];
//     // total = json['total'];
//   }

// }

// class ProductData {
//  late  int id;
//   late int price;
//   late int oldPrice;
//   late int discount;
//   late String image;
//  late  String name;
//   late String description;
//   late List<String> images;
//   late bool inFavorites;
//  late  bool inCart;


//   ProductData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     oldPrice = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//     name = json['name'];
//     description = json['description'];
//     images = json['images'].cast<String>();
//     inFavorites = json['in_favorites'];
//     inCart = json['in_cart'];
//   }

// }


class SearchModel {
  late  bool status;

  late  Data data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    data = Data.fromJson(json['data']);
  }
}

class Data {
  late  int currentPage;
  late  List<Product> data;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];

    data = <Product>[];
    json['data'].forEach((v) {
      data.add(Product.fromJson(v));
    });
  }
}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? img;
  String? name;
  bool? inFavourite;
  bool? inCart;
  Product.fromJson(Map<String, dynamic> json) {
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


