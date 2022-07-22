import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/search/cubit/states.dart';

import '../../../models/search_model.dart';
import '../../../shared/components/constance.dart';
import '../../../shared/network/end_point.dart';
import '../../../shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);

//GetSearchData

  late SearchModel searchModel;

  void getSearchData(
    String? text,
  ) {
    emit(SearchLoadingData());
    DioHelper.postData(token: token, url: SEARCH, data: {
      'text': text,
    }).then((value) {
      searchModel = SearchModel.fromJson(value?.data);
       
      emit(SearchDataSuccess());
    }).catchError((error) {
      print("// ${error.toString()} //");
      emit(SearchDataError());
    });
  }
}
