class LocationModel {
  late String? place;
  late String? describtion;

  LocationModel({this.place, this.describtion});

  LocationModel.fromJson(Map<String, dynamic> json) {
    place = json['place'];
    describtion = json['describtion'];
  }
}
