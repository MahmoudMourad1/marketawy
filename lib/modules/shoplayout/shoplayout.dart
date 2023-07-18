import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/shop_login_screen/cubit/cubit.dart';
import 'package:shopapp/modules/shop_login_screen/cubit/states.dart';
import 'package:shopapp/modules/shop_login_screen/login_shop_screen.dart';
import 'package:shopapp/network/local/cache_helper.dart';
import 'package:shopapp/shared/components.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => ShopCubit()..GetHomeData()..GetCategoriesModel(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = ShopCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.grey[300],
          appBar:AppBar(
            backgroundColor: Colors.deepPurple,
            title: Text('Marktawy'),
            actions: [
              IconButton(onPressed: (){
                CacheHelper.removeData(key: 'token').then((value){
                  NavigateAndFinish(context, ShopLoginScreen());
                });
              }, icon: (Icon(Icons.logout)))
            ],
          ),
            body: cubit.Screen[cubit.Currentindex],
            bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: Colors.deepPurple,
                onTap: (index){
                  cubit.ChangeScreens(index);
                },
                items: [
              Icon( Icons.home_rounded),
                  Icon( Icons.favorite_border),
                  Icon((Icons.shopping_cart)),
                  Icon(Icons.settings),
            ]),





        );
        }
      ),
    );
  }
}
