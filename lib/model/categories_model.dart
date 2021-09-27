class CategoriesModel {
  late bool status;

   CategoryDataModel? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoryDataModel.fromJson(json['data']);
  }
}

class CategoryDataModel {
   int? currentPage;
  List<CategoryData> categoryData = [];

  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      categoryData.add(CategoryData.fromJson(element));
    });
  }
}

class CategoryData {
  late int id;

  late String name;
  late String image;

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
