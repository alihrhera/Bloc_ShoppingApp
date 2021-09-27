import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopingapp/modules/home_screen/cubit/cubit.dart';
import 'package:shopingapp/modules/home_screen/cubit/states.dart';
import 'package:shopingapp/modules/login_screen/shopping_login_screen.dart';
import 'package:shopingapp/modules/search/search.dart';
import 'package:shopingapp/network/local/cache_helper.dart';
import 'package:shopingapp/shared/components/components.dart';

class Home extends StatelessWidget {
//  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeShopCubit()..getHomeData()..getCategoryData()..getFavorites()..getUser(),
      child: BlocConsumer<HomeShopCubit, HomeShopAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'shopy',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.1,
                ),
              ),
              actions: [

                IconButton(
                    onPressed: () =>
                        navigateTo(context: context, widget: SearchScreen()),
                    icon: Icon(Icons.search , color: Colors.white,)),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavIndex(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps), label: 'Categorise'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border_outlined),
                    label: 'Favorite'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ],
            ),
            body: cubit.bottomScreens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
