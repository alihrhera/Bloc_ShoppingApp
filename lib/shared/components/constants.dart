
import 'package:shopingapp/modules/login_screen/shopping_login_screen.dart';
import 'package:shopingapp/network/local/cache_helper.dart';

import 'components.dart';

String? token;

void logOut(context){
  CacheHelper.removeData(key: 'token');
  navigateAndFinish(widget: ShopLogin(), context: context);
}