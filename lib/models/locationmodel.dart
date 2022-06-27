class LocationModel {
  late String? placeID;
  late String? describtion;

  LocationModel({this.placeID, this.describtion});

  LocationModel.fromJson(Map<String, dynamic> json) {
    placeID = json['place_id'];
    describtion = json['description'];
  }
}
