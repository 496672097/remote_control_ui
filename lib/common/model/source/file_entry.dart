/// path : "./.git"
/// name : ".git"
/// is_dir : true

class FileEntry {
  FileEntry(
      String name, 
      bool isDir){
    _name = name;
    _isDir = isDir;
}

  FileEntry.fromJson(dynamic json) {
    _name = json['name'];
    _isDir = json['is_dir'];
  }
  late String _name;
  late bool _isDir;

  String get name => _name;
  bool get isDir => _isDir;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['is_dir'] = _isDir;
    return map;
  }

}