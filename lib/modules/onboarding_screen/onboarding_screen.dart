import 'package:flutter/material.dart';
import 'package:shopapp/network/local/cache_helper.dart';
import 'package:shopapp/shared/components.dart';
import 'package:shopapp/modules/shop_login_screen/login_shop_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class onBoardingModel{
  final String img;
  final String title;
  final String body;

  onBoardingModel({
    required this.title,
    required this.body,
    required this.img,
});
}
class onboardingScreen extends StatefulWidget {
  @override
  State<onboardingScreen> createState() => _onboardingScreenState();
}


class _onboardingScreenState extends State<onboardingScreen> {
  var onBoardController = PageController();

  List<onBoardingModel> boarding = [
    onBoardingModel(title: 'title 1 ', body: 'body 1', img: 'assets/images/onboarding.jpg'),
    onBoardingModel(title: 'title 2 ', body: 'body 2', img: 'assets/images/onboarding.jpg'),
    onBoardingModel(title: 'title 3 ', body: 'body 3', img: 'assets/images/onboarding.jpg'),

  ];
  bool isLast = false;
  // void Submit (){
  //   CacheHelper.setData(key: 'OnBoarding', value: true).then((value){
  //     if(value){
  //       NavigateAndFinish(context, ShopLoginScreen());
  //     }
  //   });
  //
  // }
  void subimt(){
    CacheHelper.setData(key: 'onBoarding', value: true).then((value){    if(value){
      NavigateAndFinish(context, ShopLoginScreen());
    }  }).catchError((error){
      print(error.toString());  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        actions: [TextButton(
          onPressed: subimt
        , child: Text('SKIP',style: TextStyle(color: Colors.white),),)],
      ),
      backgroundColor: Colors.white,
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(

          children: [
          Expanded(child: PageView.builder(itemBuilder:(context,index)=>BuildOnboardingItem(boarding[index]),
            itemCount: boarding.length,
            physics: BouncingScrollPhysics(),
            controller: onBoardController,
            onPageChanged: (int index) {
            if (index == boarding.length-1){
              print('last');
              setState(() {
                isLast=true;
              });
            }else{
              setState(() {
                isLast= false;
              });
            }

            },
          )),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(controller: onBoardController,

                    count: boarding.length,
                    effect: ScrollingDotsEffect(
                      spacing: 7,
                      dotHeight: 5,
                      dotWidth: 10,
                      dotColor: Colors.grey,
                      activeDotColor: Colors.deepPurple

                    ),

                ),
                Spacer(),
                FloatingActionButton(onPressed: (){
                  if(isLast){
                    subimt();
                  }
                  else{
                    onBoardController.nextPage(duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn);
                  }

                },

                  child: Icon(Icons.arrow_forward_ios,color: Colors.white,),backgroundColor: Colors.deepPurple,)
              ],

            )
        ],),
      )


    );


  }

  Widget BuildOnboardingItem (onBoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  [
      Expanded(child: Image(image:AssetImage('${model.img}'))),
      Text(
        '${model.title}',
        style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
        ),
      ),
      SizedBox(height: 10.0,),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 14.0,

        ),
      ),



    ],
  );


}
