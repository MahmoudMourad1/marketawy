import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/shopapp/categoriesmodel.dart';
import 'package:shopapp/models/shopapp/homemodel.dart';
import 'package:shopapp/modules/shop_login_screen/cubit/cubit.dart';
import 'package:shopapp/modules/shop_login_screen/cubit/states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <ShopCubit,ShopStates>(
     listener: (context,state){},
      builder: (context,state){
      return ConditionalBuilder(
           condition: ShopCubit.get(context).homemodel !=null && ShopCubit.get(context).categoriesModel !=null,
           builder: (context)=>Productbuilder(ShopCubit.get(context).homemodel!,context,ShopCubit.get(context).categoriesModel!),
           fallback: (context)=>CircularProgressIndicator());

      },
    );


  }
  Widget Productbuilder(HomeModel model,context,categorieModel categoriemodel) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(items:model.data!.banners.map
            ((e) =>Image(image: CachedNetworkImageProvider('${e.image}',),width: double.infinity,fit: BoxFit.cover,)).toList()
              , options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                autoPlay: true,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,

              )),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Categories',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                SizedBox(height: 5,),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  height: 120,
                  child: ListView.separated(
                    physics:BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context,index)=>ProductCategoriesItem(categoriemodel.data!.data[index]),
                      separatorBuilder: (context,index)=>SizedBox(width:10,),
                      itemCount: categoriemodel.data!.data.length),
                ),
                SizedBox(height: 10,),
                Text('New Products',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              ],
            ),
          ),
          SizedBox(height: 5,),
          Container(

            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              childAspectRatio: 1/1.62,
              children: List.generate(model.data!.products.length, (index) =>ProductGridView(model.data!.products[index],context), ),

            ),


          ),

        ],
        ),
  );
  Widget ProductGridView(ProductsModel model, context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Column(
              children: [
                Image(image: CachedNetworkImageProvider('${model.image}'),height: 200),
              ],
            ),
            if(model.discount !=0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              color: Colors.red,
                child: Text('DISCOUNT',style: TextStyle(color: Colors.white,fontSize: 11.0),))
          ],
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(

            children: [
              Text('${model.name}',overflow:TextOverflow.ellipsis,maxLines: 2,style: TextStyle(fontWeight: FontWeight.bold,),),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${model.price}',overflow:TextOverflow.ellipsis,maxLines: 2,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurpleAccent),),
                  SizedBox(width: 5,),
                  if(model.discount !=0)
                  Text('${model.old_price}',overflow:TextOverflow.ellipsis,maxLines: 2,style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.grey,fontWeight: FontWeight.bold),),
                  Spacer(),
                  IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border,size: 20,),)

                ],
              ),
            ],
          ),
        ),
      ],
    ),

  );
  Widget ProductCategoriesItem(DataModel model) => Column(
    children: [
      Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          image: DecorationImage(image: CachedNetworkImageProvider('${model.image}'),fit:BoxFit.cover, ),
          borderRadius:BorderRadius.circular(20),
        ),
      ),
      SizedBox(height: 4,),
      Text('${model.name}',style: TextStyle(fontSize: 15),),
    ],
  );

}

