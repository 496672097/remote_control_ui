import 'dart:convert';

/**
 * 和服务器通信的标准传输
 */
class CommandModel{

  late String target;

  late String receiver;

  late int c_type;

  late int action;

  late String data;

  CommandModel(this.target, this.receiver, this.c_type, this.action, this.data);

  CommandModel.fromJson(String jsonString) {
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    target = jsonMap['target'];
    receiver = jsonMap['receiver'];
    c_type = jsonMap['c_type'];
    action = jsonMap['action'];
    data = jsonMap['data'].toString();
  }

  // String toJson() {
  //   return '{"target": "$target", "receiver": "$receiver", "c_type": $c_type, "action": $action, "data": ${json.encode(data)}}';
  // }

  String toJson() {
    final map = <String, dynamic>{};
    map['target'] = target;
    map['receiver'] = receiver;
    map['c_type'] = c_type;
    map['action'] = action;
    map['data'] = data;
    return json.encode(map);
  }

}