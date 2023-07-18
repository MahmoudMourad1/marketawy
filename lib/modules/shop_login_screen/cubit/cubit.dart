import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/shopapp/categoriesmodel.dart';
import 'package:shopapp/models/shopapp/categoriesmodel.dart';
import 'package:shopapp/models/shopapp/homemodel.dart';
import 'package:shopapp/models/shopapp/shopapp.dart';
import 'package:shopapp/modules/cateogries/cateogries_screen.dart';
import 'package:shopapp/modules/favourite/favourite_screen.dart';
import 'package:shopapp/modules/products/productsScreen.dart';
import 'package:shopapp/modules/settings/settings_screen.dart';
import 'package:shopapp/modules/shop_login_screen/cubit/states.dart';
import 'package:shopapp/modules/shoplayout/shoplayout.dart';
import 'package:shopapp/network/Remote/dio_helper.dart';
import 'package:shopapp/shared/constants.dart';


import '../../../models/shopapp/categoriesmodel.dart';
import '../../../network/end_points.dart';

class ShopCubit  extends Cubit<ShopStates>
{
  ShopCubit () :super (ShopLoginInitialState());

static ShopCubit get(context)=> BlocProvider.of(context);

int Currentindex=0;

List<Widget> Screen = [
  ProductsScreen(),
  FavouriteScreen(),
  CateogriesScreen(),
  SettingsScreen()
];

void ChangeScreens (int index){
  Currentindex = index;
  emit(ShopbottomNavState());
}

ShopLoginModel? loginModel;

void userLogin( {
  required String email,
  required String password
}){
  emit(ShopLoginLoadingState());
  dioHelper.postData(
      url: Login,
      data: {'email':email,'password':password}
  ).then((value){
    print(value.data);
    loginModel=ShopLoginModel.fromJson(value.data);
    print(loginModel?.status);
    print(loginModel?.message);
    print(loginModel?.data?.token);
    emit(ShopLoginSuccessState(loginModel!));
  }).catchError((error){
    print(error.toString());
    emit(ShopLoginErrorState(error.toString()));
  });

}


IconData suffix = Icons.visibility_outlined;
bool isPassword = true;

void changePasswordVisibility()
{

  isPassword= !isPassword;
  suffix= isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
  emit(ShopPasswordVisibilityState());

}

HomeModel? homemodel;
void GetHomeData (){
  emit(ShopgetdataLoadingState());
   dioHelper.getData(
     url: Home,
     token: token,
   ).then((value) {
     print(value);
     homemodel = HomeModel.FromJson(value.data);
     print(homemodel?.status);


     emit(ShopgetdataSuccessState());

   }).catchError((error){
     print(error.toString());
     emit(ShopgetdataErrorState());
   });

}

  categorieModel? categoriesModel;
  void GetCategoriesModel (){

    dioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      print(value);
      categoriesModel = categorieModel.fromJson(value.data);
      print(categoriesModel?.status);


      emit(ShopcategoriedataSuccessState());

    }).catchError((error){
      print(error.toString());
      emit(ShopcategoriedataErrorState());
    });

  }

}

