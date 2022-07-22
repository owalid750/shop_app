
import 'package:shop_app/models/change_favorites_model.dart';

import 'package:shop_app/models/login_model.dart';

abstract class LayOutStates {}

class LayOutInitialState extends LayOutStates {}

class LayOutChangeBottomNav extends LayOutStates {}

class LayOutLoadingData extends LayOutStates {}

class LayOutLoadingDataSuccess extends LayOutStates {
  // final HomeModel homeModel;

  // LayOutLoadingDataSuccess(this.homeModel);
}

class LayOutLoadingDataError extends LayOutStates {}

class LayOutCategoriesDataSuccess extends LayOutStates {}

class LayOutCategoriesDataError extends LayOutStates {}

class LayOutFavoriteDataSuccess extends LayOutStates {}

class LayOutGetFavoriteDataLoading extends LayOutStates {}

class LayOutProfileDataError extends LayOutStates {}

class LayOutProfileDataSuccess extends LayOutStates {
  final LoginModel loginModel;

  LayOutProfileDataSuccess(this.loginModel);
}

class LayOutFavoriteDataError extends LayOutStates {}

class LayOutChangeFavoriteData extends LayOutStates {}

class LayOutChangeFavoriteDataSuccess extends LayOutStates {
  final ChangeFavoritesModel model;

  LayOutChangeFavoriteDataSuccess(this.model);
}

class LayOutChangeFavoriteDataError extends LayOutStates {}

class LayOutChangeProfileLoadingData extends LayOutStates {}

class LayOutChangeProfileDataSuccess extends LayOutStates {
    final LoginModel model;

  LayOutChangeProfileDataSuccess(this.model);
}

class LayOutChangeProfileDataError extends LayOutStates {}
