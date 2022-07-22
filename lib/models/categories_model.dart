// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategoriesModel {
 late  bool status;

 late CategoriesDataModel data;
 

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
 late int currentPage;
  late List<DataModel> data;
  // CategoriesDataModel({
  //   required this.currentPage,
  //   required this.data,
  // });

  // String? firstPageUrl;
  // int? from;
  // int? lastPage;
  // String? lastPageUrl;
  // Null? nextPageUrl;
  // String? path;
  // int? perPage;
  // Null? prevPageUrl;
  // int? to;
  // int? total;
  // int? id;
  // String? name;
  // String? image;

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];

    data = <DataModel>[];
    json['data'].forEach((v) {
      data.add(DataModel.fromJson(v));
    });

    // firstPageUrl = json['first_page_url'];
    // from = json['from'];
    // lastPage = json['last_page'];
    // lastPageUrl = json['last_page_url'];
    // nextPageUrl = json['next_page_url'];
    // path = json['path'];
    // perPage = json['per_page'];
    // prevPageUrl = json['prev_page_url'];
    // to = json['to'];
    // total = json['total'];
  }
}

class DataModel {
 late  int id;
  late String name;
 late  String image;
  // DataModel({
  //   required this.id,
  // required   this.name,
  //   required  this.image,
  // });

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
