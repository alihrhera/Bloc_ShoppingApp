
import 'package:shopingapp/model/user_model.dart';

abstract class ShopSearchStates{}

class ShopSearchInitialState extends ShopSearchStates{}
class ShopSearchLoadingState extends ShopSearchStates{}
class ShopSearchSuccessState extends ShopSearchStates{

}

class ShopSearchErrorState extends ShopSearchStates{
  String error;

  ShopSearchErrorState(this.error);
}