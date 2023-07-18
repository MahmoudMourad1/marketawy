import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/modules/shop_login_screen/cubit/cubit.dart';
import 'package:shopapp/modules/shop_login_screen/cubit/states.dart';
import 'package:shopapp/modules/shop_register_screen/shop_register_screen.dart';
import 'package:shopapp/modules/shoplayout/shoplayout.dart';
import 'package:shopapp/network/local/cache_helper.dart';
import 'package:shopapp/shared/components.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);
var formKey = GlobalKey<FormState>();
  var EmailController= TextEditingController();
  var PasswordController= TextEditingController();
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){
          if (state is ShopLoginSuccessState){
            if(state.loginModel!.status!){
              print(state.loginModel.message);
              print(state.loginModel.status);
             CacheHelper.setData(key: 'token',
                 value: state.loginModel.status).then((value){
                   NavigateAndFinish(context, ShopLayout());
             });
            }else
              {
                print(state.loginModel.message);
                Fluttertoast.showToast(
                    msg: state.loginModel.message!,
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 5,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }

          }


        },
        builder: (context,state)=>Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          backgroundColor: Colors.white,
          body:
          Center(

            child: SingleChildScrollView(
              child: Padding(

                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Login',style:TextStyle(color: Colors.black,fontSize:40.0,fontWeight: FontWeight.bold),),
                      Text('Welcome to our Shoping App',style: TextStyle(color: Colors.grey,fontSize: 20.0),),
                      SizedBox(height: 30.0,),

                  TextFormField(

                    controller: EmailController,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      border:OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator:(String? value){
                      if(value!.isEmpty){
                        return 'Email must not be empty';
                      }
                      return null;
                    },
                    textAlign:TextAlign.start,
                  ),
                      SizedBox(
                        height: 15.0,
                      ),
                  TextFormField(
                    controller: PasswordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border:OutlineInputBorder(),
                      suffixIcon: IconButton(icon:Icon(ShopCubit.get(context).suffix),onPressed: (){
                        ShopCubit.get(context).changePasswordVisibility();
                      },),
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                    ),
                    obscureText: ShopCubit.get(context).isPassword,
                    onFieldSubmitted:(value) {
                      if(formKey.currentState!.validate()){
                        ShopCubit.get(context).userLogin(email: EmailController.text,
                            password: PasswordController.text
                        );
                      }
                    },
                    validator:(String? value){
                      if(value!.isEmpty){
                        return 'please check your password';
                      }
                      return null;
                    },
                    textAlign:TextAlign.start,
                  ),
                      SizedBox(height: 20.0,),
                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState,
                        builder: (BuildContext context)=>defaultButton(width: 400.0,
                          background: Colors.deepPurple,
                          text: 'LOGIN',
                          function: (){
                          if(formKey.currentState!.validate()){
                            ShopCubit.get(context).userLogin(email: EmailController.text,
                                password: PasswordController.text
                            );
                          }
                          },
                        ),
                        fallback: (BuildContext context)=>Center(child: CircularProgressIndicator()),

                      ),
                      SizedBox(height: 10.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Dont Have an account?',style: TextStyle(color: Colors.black,),),
                          TextButton(onPressed: (){
                            NavigateTo(context, ShopRegisterScreen());
                          }, child: Text('REGISTER',))

                        ],

                      )

                    ],

                  ),
                ),
              ),
            ),
          ),
        ),

      ),
    );
  }
}
