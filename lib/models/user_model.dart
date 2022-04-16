class UserModel
{
  String? name;
  String? email;
  String? phone;
  String? uid;
  String? image;


  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uid,
    this.image,

  });

  UserModel.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    email= json['email'];
    phone = json['phone'];
    uid = json['uid'];
    image = json['image'];

  }

  Map<String, dynamic> toMap()
  {
    return
      {
        'name' : name,
        'email' : email,
        'phone' : phone,
        'uid' : uid,
        'image' : image,

      };
  }

}