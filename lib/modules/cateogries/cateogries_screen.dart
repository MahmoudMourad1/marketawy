import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/shopapp/categoriesmodel.dart';
import '../shop_login_screen/cubit/cubit.dart';
import '../shop_login_screen/cubit/states.dart';


class CateogriesScreen extends StatelessWidget {
  const CateogriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state) {
        return ConditionalBuilder(
            condition: ShopCubit
                .get(context)
                .homemodel != null && ShopCubit
                .get(context)
                .categoriesModel != null,
            builder: (context){
              return ListView.separated(
                physics: BouncingScrollPhysics() ,
                itemBuilder: (context,index)=>catList(ShopCubit.get(context).categoriesModel!.data!.data[index]),
                separatorBuilder:(context,index)=> SizedBox(height: 10.0,),
                itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
              );

            },
            fallback: (context) => CircularProgressIndicator());
      });
      }
  }
  Widget catList(DataModel model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: CachedNetworkImageProvider('${model.image}'),
          height: 80,
          width: 80,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 40,),
        Text(
          '${model.name}',
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20
          ),
        ),
        Spacer(),
        IconButton(onPressed: (){},
            icon: Icon(Icons.arrow_forward_ios))
      ],
    ),
  );


// ListView.separated(
//           physics: BouncingScrollPhysics() ,
//           itemBuilder: (context,index)=>catList(ShopCubit.get(context).categoriesModel!.data.data[index]),
//           separatorBuilder:(context,index)=> SizedBox(height: 10.0,),
//           itemCount: ShopCubit.get(context).categoriesModel!.data.data.length,
//     ));