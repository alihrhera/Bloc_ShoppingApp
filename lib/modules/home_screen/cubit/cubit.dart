import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopingapp/layout/buttom_nav/categorise/categorise.dart';
import 'package:shopingapp/layout/buttom_nav/favorite/favorites.dart';
import 'package:shopingapp/layout/buttom_nav/product/products.dart';
import 'package:shopingapp/layout/buttom_nav/settings/settings.dart';
import 'package:shopingapp/model/categories_model.dart';
import 'package:shopingapp/model/change_favorites_model.dart';
import 'package:shopingapp/model/get_favorites_model.dart';
import 'package:shopingapp/model/home_model.dart';
import 'package:shopingapp/model/user_model.dart';
import 'package:shopingapp/modules/home_screen/cubit/states.dart';
import 'package:shopingapp/network/remote/dio_helper.dart';

import 'package:shopingapp/shared/components/constants.dart';
import 'package:shopingapp/shared/components/end_point.dart';

class HomeShopCubit extends Cubit<HomeShopAppStates> {
  HomeShopCubit() : super(InitialHomeShopAppState());

  static HomeShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  Map<int, bool> favorites = {};
  List<Widget> bottomScreens = [
    Products(),
    Categorise(),
    Favorites(),
    Settings(),
  ];

  void changeBottomNavIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavHomeShopAppState());
  }

   HomeModel? homeModel;

  void getHomeData() async{
    emit(LoadingHomeShopAppState());
    await DioHelper.getData(url: HOME, token: token).then((value) {
      if(value.data != null ){
        homeModel = HomeModel.fromJson(value.data);
        homeModel!.data!.products.forEach((element) {
          favorites.addAll({
            element.id: element.inFavorites,
          });
        });
        emit(HomeShopAppSuccessState(homeModel!));
      }else{
        emit(HomeShopAppErrorState('home data error'));
      }



    }).catchError((error) {
      emit(HomeShopAppErrorState(error.toString()));
    });
  }

   CategoriesModel? categoriesModel;

  void getCategoryData() {
    emit(CategoryShopAppLoadingState());
    DioHelper.getData(url: CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(CategoryShopAppSuccessState());
    }).catchError((error) {
      emit(CategoryShopAppErrorState(error.toString()));
    });
  }

   FavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ChangeUiFavoritesShopAppSuccessState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = FavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }

      emit(ChangeFavoritesShopAppSuccessState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;

      emit(ChangeFavoritesShopAppErrorState(error.toString()));
    });
  }

   GetFavoritesModel? favoritesModel;

  void getFavorites() {
    emit(GetFavoritesShopAppLoadingState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = GetFavoritesModel.fromJson(value.data);

      print(favoritesModel!.data!.data![0].product!.image);

      emit(GetFavoritesShopAppSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetFavoritesShopAppErrorState(error.toString()));
    });
  }

   UserModel? userData;
  void getUser() {
    emit(GetUserShopAppLoadingState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userData = UserModel.fromJson(value.data);

      print(userData!.data!.phone);



      emit(GetUserShopAppSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserShopAppErrorState(error.toString()));
    });
  }

  void updateUser({required String name,required String phone,required String email,}) {
    emit(UpdateUserShopAppLoadingState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      data: {
        'name':name,
        'phone':phone,
        'email':email,
      },
      token: token,
    ).then((value) {
      userData = UserModel.fromJson(value.data);

      print(userData!.data!.phone);



      emit(UpdateUserShopAppSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserShopAppErrorState(error.toString()));
    });
  }

}
