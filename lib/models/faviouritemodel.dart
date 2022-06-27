class FavoriteDataModel {
  String? name;
  String? uid;
  String? image;
  String? namePost;
  String? description;
  String? place;
  String? no_of_room;
  String? no_of_bathroom;
  String? area;
  List? postImage;
  String? date;
  String? price;
  String? category;
  String? postid;
  bool? isfav;
  bool? isnegotiate;
  String? type;
  String? bundel;
  List? services;

  FavoriteDataModel(
      {this.name,
      this.uid,
      this.image,
      this.namePost,
      this.description,
      this.place,
      this.no_of_room,
      this.no_of_bathroom,
      this.area,
      this.postImage,
      this.price,
      this.date,
      this.category,
      this.postid,
      this.isfav,
      this.bundel,
      this.type,
      this.isnegotiate,
      this.services});
  FavoriteDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
    image = json['image'];
    namePost = json['namePost'];
    description = json['description'];
    place = json['place'];
    no_of_room = json['no_of_room'];
    no_of_bathroom = json['no_of_bathroom'];
    area = json['area'];
    postImage = json['postImage'];
    price = json['price'];
    date = json['date'];
    category = json['category'];
    postid = json['postid'];
    isfav = json['isfav'];
    bundel = json['bundel'];
    type = json['type'];
    isnegotiate = json['isnegatiated'];
    services = json['services'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'image': image,
      'namePost': namePost,
      'description': description,
      'place': place,
      'no_of_room': no_of_room,
      'no_of_bathroom': no_of_bathroom,
      'area': area,
      'postImage': postImage,
      'price': price,
      'date': date,
      'category': category,
      'postid': postid,
      'isfav': isfav,
      'bundel': bundel,
      'isnegotiate': isnegotiate,
      'type': type,
      'services': services
    };
  }
}
