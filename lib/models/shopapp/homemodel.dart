

class HomeModel{
  bool? status;
  HomeDataModel? data;

  HomeModel.FromJson(Map<String,dynamic>json){
    status = json['status'];
    data =HomeDataModel.FromJson(json['data']);
  }
}
class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductsModel> products = [];
  HomeDataModel.FromJson(Map<String,dynamic>json){
    json['banners'].forEach((element){
      banners.add(BannerModel.FromJson(element));
    });
    json['products'].forEach((element){
      products.add(ProductsModel.FromJson(element));
    });
  }
}

class BannerModel{
  dynamic id;
  dynamic image;
  BannerModel.FromJson(Map<String,dynamic>json){
    id=json['id'];
    image=json['image'];
  }

}
class ProductsModel {
  int? id;
  dynamic image;
  String? name;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  bool? Favourtie;
  bool? InCart;
  ProductsModel.FromJson(Map<String,dynamic>json){
    id=json['id'];
    image=json['image'];
    name=json['name'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    Favourtie=json['in_favorites'];
    InCart=json['in_cart'];
  }

}