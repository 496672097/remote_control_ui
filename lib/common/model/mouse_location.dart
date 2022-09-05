import 'dart:convert';

/// x : 1
/// y : 122

class MouseLocation {
  MouseLocation(
      int x, 
      int y){
    _x = x;
    _y = y;
}

  MouseLocation.fromJson(dynamic json) {
    _x = json['x'];
    _y = json['y'];
  }
  late int _x;
  late int _y;

  int get x => _x;
  int get y => _y;

  String toJson() {
    final map = <String, dynamic>{};
    map['x'] = _x;
    map['y'] = _y;
    return json.encode(map);
  }

}