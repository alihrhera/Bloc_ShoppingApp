import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopingapp/model/search_model.dart';
import 'package:shopingapp/modules/home_screen/cubit/cubit.dart';
import 'package:shopingapp/modules/search/cubit/states.dart';

import 'package:shopingapp/modules/search/cubit/cubit.dart';
import 'package:shopingapp/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  //const Favorites({Key? key}) : super(key: key);
  final searchController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, ShopSearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopSearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text('Search'),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                          hint: 'Search',
                          controller: searchController,
                          onChange: (title) {
                            cubit.userSearch(title: title);
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      cubit.searchModel != null
                          ? ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => buildSearchItem(
                                  cubit.searchModel!.data!.product![index],
                                  context),
                              separatorBuilder: (context, index) => myDivider(),
                              itemCount:
                                  cubit.searchModel!.data!.product!.length)
                          : Center(child: CircularProgressIndicator()),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /*
  *  ConditionalBuilder(
                        condition: cubit.searchModel != null,
                        builder: (context) => ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => buildSearchItem(

                                cubit.searchModel.data!.product![index],context),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: cubit.searchModel.data!.product!.length),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
  *
  * */

  Widget buildSearchItem(ProductSearchItem model, context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 120.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120.0,
                height: 120.0,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image(
                      image: NetworkImage(model.image),
                      height: 120.0,
                      width: 120.0,
                    ),
                    // if (cubit.favoritesModel.data.product.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 8.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        height: 1.3,
                        letterSpacing: 0.1,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.price}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 16.0,
                            letterSpacing: 0.1,
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Spacer(),
                        /* IconButton(
                        onPressed: () {
                         */ /* HomeShopCubit.get(context)
                              .changeFavorites(model.id);*/ /*
                        },
                        icon: Icon(
                          Icons.favorite_border_outlined,
                          color: HomeShopCubit.get(context)
                              .favorites[model.inFavorites]
                              ? Colors.deepOrange
                              : Colors.grey,
                        )),*/
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
