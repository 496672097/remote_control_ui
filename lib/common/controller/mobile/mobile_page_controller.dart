import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MobilePageController extends GetxController{

  PageController controller = PageController();

  int pageIndex = 0;

  void updatePageIndex(int index){
    pageIndex = index;
    update();
  }

}