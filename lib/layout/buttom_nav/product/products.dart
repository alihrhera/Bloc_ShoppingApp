import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopingapp/model/categories_model.dart';
import 'package:shopingapp/model/home_model.dart';
import 'package:shopingapp/modules/home_screen/cubit/cubit.dart';
import 'package:shopingapp/modules/home_screen/cubit/states.dart';
import 'package:shopingapp/shared/components/components.dart';

class Products extends StatelessWidget {
  //const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeShopCubit, HomeShopAppStates>(
      listener: (context, state) {
        if (state is ChangeFavoritesShopAppSuccessState) {
          if (!state.model.status) {
            showToast(text: state.model.message!, state: ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {
        var cubit = HomeShopCubit.get(context);
        return cubit.homeModel != null && cubit.categoriesModel !=null
            ? builderWidget(cubit.homeModel!, cubit.categoriesModel, context)
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }



  Widget builderWidget(
          HomeModel model, categoriesModel ,context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model.data!.banners
                    .map((e) => Image(
                          image: NetworkImage('${e.image}'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                  scrollDirection: Axis.horizontal,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  reverse: false,
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  viewportFraction: 1.0,
                  height: 250.0,
                  initialPage: 0,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CATEGORIES',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.1,
                      fontSize: 24,
                    ),
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCategoryItem(
                            categoriesModel.data.categoryData[index]),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 8,
                            ),
                        itemCount: categoriesModel.data.categoryData.length),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'NEW PRODUCT',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.1,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey.shade300,
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 2.5,
                childAspectRatio: 1 / 1.48,
                children: List.generate(
                    model.data!.products.length,
                    (index) =>
                        buildGridItem(model.data!.products[index], context)),
              ),
            ),
          ],
        ),
      );

  Widget buildGridItem(ProductModel model, context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(model.image),
                height: 200,
                width: double.infinity,
              ),
              if (model.discount != 0)
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
          Padding(
            padding: const EdgeInsets.all(12.0),
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
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
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
                    if (model.oldPrice != 0)
                      Text(
                        '${model.oldPrice.round()}',
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
                          HomeShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: HomeShopCubit.get(context).favorites[model.id]!
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
    );
  }

  Widget buildCategoryItem(CategoryData model) => Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Image(
            image: NetworkImage(model.image),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Container(
            width: 100,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
            ),
            child: Text(
              model.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
}
