import 'package:flutter/material.dart';
import 'package:shopingapp/modules/login_screen/shopping_login_screen.dart';
import 'package:shopingapp/modules/onboarding_screen/boarding_model.dart';
import 'package:shopingapp/network/local/cache_helper.dart';
import 'package:shopingapp/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  //OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  bool isLast = false;

  final List<BoardingModel> boards = [
    BoardingModel(
      image: 'assets/images/splash_1.png',
      body:
          'Easily find your grocery items and you will get delivery in wide range',
      title: 'Choose your item',
    ),
    BoardingModel(
      image: 'assets/images/splash_2.png',
      body:
          'We make ordering fast, simple and free-no matter if you order online or cash',
      title: 'Pick Up or Delivery',
    ),
    BoardingModel(
      image: 'assets/images/splash_3.png',
      body: 'Pay for order using credit or debit card',
      title: 'Pay quick and easy',
    ),
  ];

  void onBoardingSaved(){
    CacheHelper.saveData(key:'onBoarding',value: true).then((value) => {
      if(value){
        navigateAndFinish(context: context, widget: ShopLogin()),
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          defaultTextButton(
            tap:onBoardingSaved,
            color: Colors.blue,
            title: 'SKIP',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boards[index]),
                itemCount: boards.length,
                onPageChanged: (index) {
                  if (index == boards.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boards.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    spacing: 5.0,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    expansionFactor: 4.0,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      onBoardingSaved();
                    } else {
                      boardController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.keyboard_arrow_right_outlined),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage('${model.image}'))),
          Text(
            '${model.title}',
            style: TextStyle(color: Colors.black, fontSize: 24.0),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            '${model.body}',
            style: TextStyle(color: Colors.black, fontSize: 14.0),
          ),
        ],
      );
}
