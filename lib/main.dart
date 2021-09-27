import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopingapp/modules/login_screen/shopping_login_screen.dart';
import 'package:shopingapp/network/local/cache_helper.dart';
import 'package:shopingapp/network/remote/dio_helper.dart';
import 'package:shopingapp/shared/components/constants.dart';
import 'package:shopingapp/shared/my_bloc_observer.dart';

import 'modules/home_screen/home_layout.dart';
import 'modules/onboarding_screen/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  bool? onboard = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
   Widget widget;
  if (onboard != null) {
    if (token != null) {
      widget = Home();
    } else {
      widget = ShopLogin();
    }
  } else {
    widget = OnBoardingScreen();
  }

  print(onboard);
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget widget;

  MyApp(this.widget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.blue.withOpacity(0.4),


        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          elevation: 20.0,

        ),
        fontFamily: 'Jannah',
        primarySwatch: Colors.blue,
      ),
      home: widget,
    );
  }
}
