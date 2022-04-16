class CategoryDataModel {
  String? categoryName;
  String? categoryImage;

  CategoryDataModel(
    this.categoryName,
    this.categoryImage,
  );

  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    categoryImage = json['image'];
    categoryName = json['name'];
  }

  Map<String, dynamic> toMap() {
    return {
      'image': categoryName,
      'name': categoryImage,
    };
  }
}
