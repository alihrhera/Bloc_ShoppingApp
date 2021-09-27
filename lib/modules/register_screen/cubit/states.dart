
import 'package:shopingapp/model/user_model.dart';

abstract class ShopRegisterStates{}

class ShopRegisterInitialState extends ShopRegisterStates{}
class ShopRegisterLoadingState extends ShopRegisterStates{}
class ShopRegisterSuccessState extends ShopRegisterStates{

   UserModel model;

  ShopRegisterSuccessState(this.model);
}

class ShopRegisterErrorState extends ShopRegisterStates{
  String error;

  ShopRegisterErrorState(this.error);
}

class PasswordChangeRegisterVisibility extends ShopRegisterStates{}