class HelpingPostModel {
  String ?image;
  String ?name;
  String ?uId;
  String ?postId;
  String ?dateTime;
  String ?text;
  int ?like;
  int ?comment;

// constructor
  HelpingPostModel({
    this.image,
    this.name,
    this.uId,
    this.postId,
    this.dateTime,
    this.text,
    this.like,
    this.comment,
  });

// named constructor

  HelpingPostModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    uId = json['uId'];
    dateTime = json['dateTime'];
    text = json['text'];
    like = json['like'];
    postId = json['postId'];
    comment = json['comment'];
  }

// to map
  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'uId': uId,
      'dateTime': dateTime,
      'text': text,
      'like': like,
      'comment': comment,
      'postId': postId,
    };
  }
}