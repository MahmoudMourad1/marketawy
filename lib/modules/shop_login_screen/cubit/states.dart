import 'package:shopapp/models/shopapp/shopapp.dart';

abstract class ShopStates {}

class ShopLoginInitialState extends ShopStates{}
class ShopLoginLoadingState extends ShopStates{}
class ShopLoginSuccessState extends ShopStates{
  final ShopLoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);

}
class ShopLoginErrorState extends ShopStates{
  final String error;
  ShopLoginErrorState(this.error);
}

class ShopPasswordVisibilityState extends ShopStates{}

class ShopbottomNavState extends ShopStates{}


class ShopgetdataLoadingState extends ShopStates{}
class ShopgetdataSuccessState extends ShopStates{}
class ShopgetdataErrorState extends ShopStates{}


class ShopcategoriedataSuccessState extends ShopStates{}
class ShopcategoriedataErrorState extends ShopStates{}