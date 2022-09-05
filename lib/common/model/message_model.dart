class MessageModel{

  late String username;

  late String content;

  late String sendTime;

  MessageModel({required this.username, required this.content, required this.sendTime});

  MessageModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    content = json['content'];
    sendTime = json['sendTime'];
  }

  String toJson() {
    return '{"username": "$username", "content": "$content", "sendTime": "$sendTime"}';
  }

}