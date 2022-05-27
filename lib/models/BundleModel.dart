class BunndelModel {
  String? bundleName;
  int? bundleDuration;
  String? price;

  BunndelModel(
    this.bundleName,
    this.bundleDuration,
    this.price,
  );

  BunndelModel.fromJson(Map<String, dynamic> json) {
    bundleName = json['bundleName'];
    bundleDuration = json['bundleDuration'];
    price = json['price'];
  }

  Map<String, dynamic> toMap() {
    return {
      'bundleName': bundleName,
      'bundleDuration': bundleDuration,
      'price': price,
    };
  }
}
