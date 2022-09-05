import 'package:get/get.dart';

class ArgsController extends GetxController{

  bool isMobile = false;

  void checkTargetOS(String os) {
    if(os == "android" || os == "ios"){
      isMobile = true;
      update();
    }
  }

  // 目标操作系统
  String _os = "";

  void setTargetOs(String os){
    _os = os;
  }

  String getTargetOs(){
    return _os;
  }

}