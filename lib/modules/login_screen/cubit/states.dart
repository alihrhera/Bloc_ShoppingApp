





import 'package:shopingapp/model/user_model.dart';

abstract class ShopLoginStates{}

class ShopLoginInitialState extends ShopLoginStates{}
class ShopLoginLoadingState extends ShopLoginStates{}
class ShopLoginSuccessState extends ShopLoginStates{

  UserModel model;

  ShopLoginSuccessState(this.model);
}

class ShopLoginErrorState extends ShopLoginStates{
  String error;

  ShopLoginErrorState(this.error);
}

class PasswordChangeVisibility extends ShopLoginStates{}