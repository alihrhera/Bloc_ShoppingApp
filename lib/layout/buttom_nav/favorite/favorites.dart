import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopingapp/model/get_favorites_model.dart';
import 'package:shopingapp/modules/home_screen/cubit/cubit.dart';
import 'package:shopingapp/modules/home_screen/cubit/states.dart';
import 'package:shopingapp/shared/components/components.dart';

class Favorites extends StatelessWidget {
  //const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeShopCubit, HomeShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeShopCubit.get(context);
        return cubit.favoritesModel != null
            ? ListView.separated(
                itemBuilder: (context, index) => buildFavItem(
                    cubit.favoritesModel!.data!.data![index], context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: cubit.favoritesModel!.data!.data!.length)
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  /*
  * ConditionalBuilder(
          condition: state is! GetFavoritesShopAppLoadingState,
          builder: (context) =>,
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
  * */

  Widget buildFavItem(FavoritesData model, context) => Padding(
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
                      image: NetworkImage(model.product!.image),
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
                      model.product!.name,
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
                          '${model.product!.price}',
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
                        if (model.product!.oldPrice != 0)
                          Text(
                            '${model.product!.oldPrice}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                              letterSpacing: 0.1,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              HomeShopCubit.get(context)
                                  .changeFavorites(model.product!.id);
                            },
                            icon: Icon(
                              Icons.favorite_border_outlined,
                              color: HomeShopCubit.get(context)
                                      .favorites[model.product!.id]!
                                  ? Colors.deepOrange
                                  : Colors.grey,
                            )),
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
