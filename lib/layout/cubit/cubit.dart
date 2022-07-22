import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';

import 'package:shop_app/models/get_favorite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/search_model.dart';

import 'package:shop_app/screens/Favourite/favourite.dart';
import 'package:shop_app/screens/Home/home.dart';
import 'package:shop_app/screens/category/category.dart';
import 'package:shop_app/screens/search/search.dart';
import 'package:shop_app/screens/settings/settings.dart';
import 'package:shop_app/shared/components/constance.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LayOutCubit extends Cubit<LayOutStates> {
  LayOutCubit() : super(LayOutInitialState());
  static LayOutCubit get(context) => BlocProvider.of(context);

  // BottomNavBar
  List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.category), label: "Category"),
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite_outline), label: "Favourite"),
    // BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
  ];
  List<Widget> screans = <Widget>[
    HomeScrean(),
    CategoryScrean(),
    FavouriteScrean(),
    // SearchScrean(),
    SettingsScrean(),
  ];
  int selectedIndex = 0;
  changeBottomNavBarIndex(index) {
    selectedIndex = index;
    emit(LayOutChangeBottomNav());
  }

  // GetHomeData
  HomeModel? homeModel;
  late Map<int?, bool?> favourite = {};
  void getHomeData() {
    emit(LayOutLoadingData());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel?.data?.products?.forEach((element) {
        favourite.addAll({
          element.id: element.inFavourite,
        });
        print(element.inFavourite);
      });

      print(homeModel?.status);
      print(homeModel?.data?.products![0].name);
      print(homeModel?.data?.products![0].price);
      emit(LayOutLoadingDataSuccess());
    }).catchError((error) {
      print("ERROR ${error.toString()} WHEN GET HOME DATA");
      emit(LayOutLoadingDataError());
    });
  }

  //GetCategoriesData

  late CategoriesModel categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(
      url: CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(LayOutCategoriesDataSuccess());
    }).catchError((error) {
      print("ERROR ${error.toString()} WHEN GET Categories DATA");
      emit(LayOutCategoriesDataError());
    });
  }

  // PostFavorites
  late ChangeFavoritesModel changeFavoritesModel;
  void changeFavoriteData(
     int? product_id,
  ) {
    favourite[product_id] = !(favourite[product_id])!;
    emit(LayOutChangeFavoriteData());

    DioHelper.postData(
      url: FAVOURITE,
      data: {
        "product_id": product_id,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value?.data);
      if (changeFavoritesModel.status == false) {
        favourite[product_id] = !favourite[product_id]!;
      } else {
        getFavoriteData();
      }
      print(value?.data);
      emit(LayOutChangeFavoriteDataSuccess(changeFavoritesModel));
    }).catchError((error) {
      print("ERROR WHEN CHANGE FAVORITE DATA ${error.toString()}");
      favourite[product_id] = !favourite[product_id]!;

      LayOutChangeFavoriteDataError();
    });
  }

//GetFavourite

  late FavoriteModel favoriteModel;

  void getFavoriteData() {
    emit(LayOutGetFavoriteDataLoading());
    DioHelper.getData(
      url: FAVOURITE,
      token: token,
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);

      emit(LayOutFavoriteDataSuccess());
    }).catchError((error) {
      print("ERROR ${error.toString()} WHEN GET FAVORITES DATA");
      emit(LayOutFavoriteDataError());
    });
  }

//GerProfileData

  late LoginModel userModel;

  void getProfileData() {
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      print(userModel.data?.name);
      print(userModel.data?.phone);

      emit(LayOutProfileDataSuccess(userModel));
    }).catchError((error) {
      print("ERROR ${error.toString()} WHEN GET PROFILE DATA");
      emit(LayOutProfileDataError());
    });
  }

//UpdateProfileData

  void updateProfileData({
    String? name,
    String? email,
    String? phone,
  }) {
    emit(LayOutChangeProfileLoadingData());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = LoginModel.fromJson(value?.data);
      print(userModel.data?.name);
      print(userModel.data?.phone);

      emit(LayOutChangeProfileDataSuccess(userModel));
    }).catchError((error) {
      print("ERROR ${error.toString()} WHEN GET UPDATE_PROFILE DATA");
      emit(LayOutChangeProfileDataError());
    });
  }
  //

}
