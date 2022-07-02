class ContactUsModel {
  String? name;
  String? uid;
  String? phone;
  String? email;
  String? problem;

  ContactUsModel({
    this.name,
    this.uid,
    this.phone,
    this.email,
    this.problem,
  });

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
    phone = json['phone'];
    email = json['email'];
    problem = json['problem'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'phone': phone,
      'email': email,
      'problem': problem,
    };
  }
}
