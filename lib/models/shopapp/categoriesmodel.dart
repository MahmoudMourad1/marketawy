class categorieModel{
  bool? status;
  categoriesDataModel? data;

  categorieModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data =categoriesDataModel.fromJson(json['data']);
  }

}

class categoriesDataModel{
int? currentPage;
List<DataModel> data = [];

categoriesDataModel.fromJson(Map<String,dynamic> json){
  currentPage = json['current_page'];
  json['data'].forEach((element){
    data.add(DataModel.fromJson(element));
  }
  );
}



}

class DataModel {
  int? id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String,dynamic>json){

    id = json['id'];
    name =json['name'];
    image = json['image'];
  }
}