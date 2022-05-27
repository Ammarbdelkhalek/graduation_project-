class MessageModel {
  String? receiverId;
  String? senderId;
  String? dateTime;
  String? text;

  MessageModel({
    this.receiverId,
    this.senderId,
    this.dateTime,
    this.text,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    receiverId = json['receiverId'];
    senderId = json['senderId'];
    text = json['text'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'receiverId': receiverId,
      'senderId': senderId,
      'text': text,
      'dateTime': dateTime,
    };
  }
}
