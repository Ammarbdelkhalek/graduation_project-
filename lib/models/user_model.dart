class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uid;
  String? image;
  String? token;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uid,
    this.image,
    this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uid = json['uid'];
    image = json['image'];
    token = json['token'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uid': uid,
      'image': image,
      'token': token,
    };
  }
}
