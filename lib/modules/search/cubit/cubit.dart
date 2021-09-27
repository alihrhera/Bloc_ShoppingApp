import 'package:bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopingapp/model/search_model.dart';
import 'package:shopingapp/modules/search/cubit/states.dart';
import 'package:shopingapp/network/remote/dio_helper.dart';
import 'package:shopingapp/shared/components/end_point.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates> {
  ShopSearchCubit() : super(ShopSearchInitialState());

  static  ShopSearchCubit get(context) => BlocProvider.of(context);



   SearchModel? searchModel;
  void userSearch({required String title}) {
    emit(ShopSearchLoadingState());
    DioHelper.postData(url: SEARCH, data: {
      'text': title,
    }).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel!.data!.product![0].name);
      emit(ShopSearchSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopSearchErrorState(onError.toString()));

    });
  }
}
