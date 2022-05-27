class ServicesModel {
  String? image;
  String? companyName;
  String? location;
  double? rate;
  String? serviceType;
  String? phone;
  String? Url;

  ServicesModel({
    this.image,
    this.companyName,
    this.location,
    this.rate,
    this.serviceType,
    this.phone,
    this.Url,
  });
  ServicesModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    companyName = json['companyName'];
    location = json['location'];
    rate = json['rate'];
    phone = json['phone'];
    serviceType = json['serviceType'];
    Url = json['Url'];
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'companyName': companyName,
      'location': location,
      'rate': rate,
      'phone': phone,
      'serviceType': serviceType,
      'Url': Url
    };
  }
}
