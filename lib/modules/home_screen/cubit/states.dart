
import 'package:shopingapp/model/change_favorites_model.dart';
import 'package:shopingapp/model/home_model.dart';

abstract class HomeShopAppStates {}

class InitialHomeShopAppState extends HomeShopAppStates{}

class LoadingHomeShopAppState extends HomeShopAppStates{}

class HomeShopAppErrorState extends HomeShopAppStates{
  final String error;

  HomeShopAppErrorState(this.error);
}

class HomeShopAppSuccessState extends HomeShopAppStates{
  final HomeModel model;

  HomeShopAppSuccessState(this.model);
}

class ChangeBottomNavHomeShopAppState extends HomeShopAppStates{}


class CategoryShopAppErrorState extends HomeShopAppStates{
  final String error;

  CategoryShopAppErrorState(this.error);
}

class  CategoryShopAppSuccessState extends HomeShopAppStates{}
class  CategoryShopAppLoadingState extends HomeShopAppStates{}

class ChangeFavoritesShopAppErrorState extends HomeShopAppStates{
  final String error;

  ChangeFavoritesShopAppErrorState(this.error);
}

class  ChangeFavoritesShopAppSuccessState extends HomeShopAppStates{
  final FavoritesModel model;

  ChangeFavoritesShopAppSuccessState(this.model);

}

class  ChangeUiFavoritesShopAppSuccessState extends HomeShopAppStates{}

class  GetFavoritesShopAppSuccessState extends HomeShopAppStates{}

class  GetFavoritesShopAppLoadingState extends HomeShopAppStates{}

class GetFavoritesShopAppErrorState extends HomeShopAppStates{
  final String error;

  GetFavoritesShopAppErrorState(this.error);
}

class ChangeUiFavoritesShopAppErrorState extends HomeShopAppStates{
  final String error;

  ChangeUiFavoritesShopAppErrorState(this.error);
}

class  GetUserShopAppSuccessState extends HomeShopAppStates{}

class  GetUserShopAppLoadingState extends HomeShopAppStates{}

class GetUserShopAppErrorState extends HomeShopAppStates{
  final String error;

  GetUserShopAppErrorState(this.error);
}

class  UpdateUserShopAppSuccessState extends HomeShopAppStates{}

class  UpdateUserShopAppLoadingState extends HomeShopAppStates{}

class UpdateUserShopAppErrorState extends HomeShopAppStates{
  final String error;

  UpdateUserShopAppErrorState(this.error);
}
