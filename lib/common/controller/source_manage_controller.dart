import 'dart:convert';
// import 'dart:html';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:remote_control_ui/common/controller/socket_controller.dart';
import 'package:remote_control_ui/common/model/command_model.dart';
import 'package:remote_control_ui/common/model/source/file_entry.dart';

import '../model/source/disk_item.dart';

class SourceManageController extends GetxController {
  List<FileEntry> entryList = [];

  List<DiskItem> diskList = [];

  TextEditingController dirController = TextEditingController();

  String downloadFileName = '';
  String? downloadPath = '';

  listDisk(){
    CommandModel commandModel = CommandModel(
        Get.find<SocketController>().target,
        Get.find<SocketController>().username.text,
        2,
        0,
        "");
    String json = commandModel.toJson();
    Get.find<SocketController>().send(json);
  }

  // 请求目录列表
  listDir(String path) {
    CommandModel commandModel = CommandModel(
        Get.find<SocketController>().target,
        Get.find<SocketController>().username.text,
        2,
        1,
        path);
    String json = commandModel.toJson();
    Get.find<SocketController>().send(json);
  }

  // 去到父级目录
  void toParent() {
    String parent =
        dirController.text.substring(0, dirController.text.lastIndexOf('/'));
    // print(parent);
    listDir(parent);
  }

  updateDisk(CommandModel commandModel){
    List list = json.decode(commandModel.data);
    for(int i = 0; i < list.length; i++){
      print(list[i][0]);
      diskList.add(DiskItem(list[i][0], list[i][1], list[i][2], list[i][3], list[i][4]));
    }
    // diskList.map((e) => print(e.toString()));
    update();
  }

  // 更新目录信息
  updateDir(String jsonString) {
    CommandModel commandModel = CommandModel.fromJson(jsonString);
    Map<String, dynamic> map = json.decode(commandModel.data);
    List fileEntryList = map['entrys'];
    entryList =
        fileEntryList.map((e) => FileEntry(e['name'], e['is_dir'])).toList();
    dirController.text = map['dir'];
    if(dirController.text.contains('?')){
      dirController.text = dirController.text
          .substring(4, dirController.text.length)
          .replaceAll("\\", "/");
    }
    update();
  }

  // 上传文件
  uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        dialogTitle: '选择要上传的文件！', allowMultiple: false, withData: true);

    if (result != null) {
      PlatformFile file = result.files.first;
      CommandModel commandModel = CommandModel(
          Get.find<SocketController>().target,
          Get.find<SocketController>().username.text,
          2,
          4,
          '${dirController.text}/${file.name}');
      // 第一次传输告诉服务器传输文件信息
      Get.find<SocketController>().send(commandModel.toJson());
      // 传输真实的字节数据
      // Get.find<SocketController>().send(json.encode(file.bytes!));
      Get.find<SocketController>().send(base64Encode(file.bytes!));
      // print(base64Encode(file.bytes!).length);
    } else {
      Get.snackbar('提示', '你取消了选择!');
    }
  }

  // 以文本方式打开
  viewFile(String name) {
    CommandModel commandModel = CommandModel(
        Get.find<SocketController>().target,
        Get.find<SocketController>().username.text,
        2,
        2,
        dirController.text + '/' + name);
    String json = commandModel.toJson();
    Get.find<SocketController>().send(json);
  }

  // 删除文件
  deleteFile(String name) {
    CommandModel commandModel = CommandModel(
        Get.find<SocketController>().target,
        Get.find<SocketController>().username.text,
        2,
        5,
        dirController.text + '/' + name);
    String json = commandModel.toJson();
    Get.find<SocketController>().send(json);
  }

  // 压缩文件夹
  void zipDir(String name) {
    print('zip dir ==> ${dirController.text + '/' + name}');
  }

  // 下载文件
  void download(String name) async {
    downloadPath = await FilePicker.platform.getDirectoryPath();
    downloadFileName = name;
    CommandModel commandModel = CommandModel(
        Get.find<SocketController>().target,
        Get.find<SocketController>().username.text,
        2,
        3,
        dirController.text + '/' + name);
    String json = commandModel.toJson();
    Get.find<SocketController>().transStatus = 1;
    Get.find<SocketController>().send(json);
  }

  // 删除更新等操作后刷新当前目录信息
  void flush() {
    listDir(dirController.text);
  }

  void saveFile(String data) async{
    File file = File('${Get.find<SourceManageController>().downloadPath}/${Get.find<SourceManageController>().downloadFileName}');
    if(!await file.exists()) await file.create();
    file.writeAsBytes(base64Decode(data));
  }
}
