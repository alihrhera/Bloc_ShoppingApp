import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopingapp/model/categories_model.dart';
import 'package:shopingapp/modules/home_screen/cubit/cubit.dart';
import 'package:shopingapp/modules/home_screen/cubit/states.dart';
import 'package:shopingapp/shared/components/components.dart';

class Categorise extends StatelessWidget {
  //const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeShopCubit, HomeShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return HomeShopCubit.get(context).categoriesModel != null
            ? ListView.separated(
                itemBuilder: (context, index) => buildCategoriesItem(
                    HomeShopCubit.get(context)
                        .categoriesModel!
                        .data!
                        .categoryData[index]),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: HomeShopCubit.get(context)
                    .categoriesModel!
                    .data!
                    .categoryData
                    .length)
            : Container();
      },
    );
  }

  Widget buildCategoriesItem(CategoryData model) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image(
              height: 120,
              width: 120,
              //fit: BoxFit.cover,
              image: NetworkImage(model.image),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              model.name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      );

/*
  *
  * ConditionalBuilder(
          condition: HomeShopCubit.get(context).categoriesModel != null,
          builder: (context) =>
          fallback: (context) =>
          ),
        );
  *
  * */
}
