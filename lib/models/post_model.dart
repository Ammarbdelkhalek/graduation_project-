class PostModel {
  String? uid;
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
  bool? isnegotiate;
  bool? TermsAndCondition;
  String? type;
  String? bundel;
  List? services;
  String? email;
  String? whatsApp;
  String? phone;
  double?lat;
  double?long;

  PostModel(
      {
      this.uid,
      this.namePost,
      this.description,
      this.place,
      this.no_of_room,
      this.no_of_bathroom,
      this.area,
      this.postImage,
        this.TermsAndCondition,
      this.price,
      this.date,
      this.category,
      this.postid,
      this.bundel,
      this.type,
      this.isnegotiate,
      this.services,
      this.email,
      this.phone,
      this.whatsApp,
      this.lat,
      this.long,
      });

  PostModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    namePost = json['namePost'];
    description = json['description'];
    place = json['place'];
    no_of_room = json['no_of_room'];
    no_of_bathroom = json['no_of_bathroom'];
    TermsAndCondition = json['TermsAndCondition'];
    area = json['area'];
    postImage = json['postImage'];
    price = json['price'];
    date = json['date'];
    category = json['category'];
    postid = json['postid'];
    bundel = json['bundel'];
    type = json['type'];
    isnegotiate = json['isnegatiated'];
    services = json['services'];
    email = json ['email'];
    phone = json ['phone'];
    whatsApp = json['whatsApp'];
    lat =json['lat'];
    long =json['long'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
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
      'bundel': bundel,
      'isnegotiate': isnegotiate,
      'type': type,
      'services': services,
      'email' : email,
      'whatsApp' :whatsApp,
      'phone' :phone,
      'lat':lat,
      'long':long,
    };
  }
}
