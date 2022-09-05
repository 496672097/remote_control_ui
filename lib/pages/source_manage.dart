import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_control_ui/common/const/base_const_args.dart';
import 'package:remote_control_ui/common/const/widget_style.dart';
import 'package:remote_control_ui/common/controller/args_controller.dart';
import 'package:remote_control_ui/common/controller/source_manage_controller.dart';
import 'package:remote_control_ui/common/model/source/disk_item.dart';
import 'package:remote_control_ui/common/model/source/file_entry.dart';

class SourceManage extends StatelessWidget {
  const SourceManage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SourceManageController());
    if (Get.find<SourceManageController>().entryList.isEmpty) {
      Get.find<SourceManageController>()
          .listDisk();
      Get.find<SourceManageController>()
          .listDir(Get.find<SourceManageController>().dirController.text);
    }

    return Container(
      child: GetBuilder<SourceManageController>(
        init: Get.find<SourceManageController>(),
        builder: (controller) {
          return Column(
            children: [
              Container(
                height: 60,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () =>
                            Get.find<SourceManageController>().toParent(),
                        icon: const Icon(Icons.arrow_back), color: WidgetStyle().defaultColor),
                    Expanded(
                      child: TextField(
                        controller: controller.dirController,
                        onSubmitted: (val) => controller.listDir(val),
                        style: WidgetStyle().defaultStyle,
                      ),
                    ),
                    IconButton(
                        onPressed: () =>
                            Get.find<SourceManageController>().uploadFile(),
                        icon: Icon(Icons.upload_rounded, color: WidgetStyle().defaultColor))
                  ],
                ),
              ),
              Get.find<ArgsController>().getTargetOs() == "windows" ? Container(
                height: 50,
                child: ListView(
                  children: controller.diskList.map((e) => diskItemView(e)).toList(),
                  scrollDirection: Axis.horizontal,
                  // children: ,
                ),
              ) : const SizedBox(),
              Expanded(
                child: ListView(
                  children:
                      controller.entryList.map((e) => EntryItem(e)).toList(),
                ),
                flex: 2,
              )
            ],
          );
        },
      ),
    );
  }

  Container EntryItem(FileEntry entry) {
    return Container(
      height: BaseConstArgs().isDeskTop ? 40 : 20,
      child: Row(
        children: [
          Icon(entry.isDir ? Icons.file_present : Icons.insert_drive_file,
              color: Colors.amber, size: BaseConstArgs().isDeskTop ? 30 : 20),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 200, child: Text(entry.name, overflow: TextOverflow.ellipsis, style: WidgetStyle().defaultStyle)),
                Row(
                  children: [
                    InkWell(
                      onTap: () => entry.isDir
                          ? Get.find<SourceManageController>().zipDir(entry.name)
                          : Get.find<SourceManageController>().download(entry.name),
                      child: Icon(entry.isDir ? Icons.map : Icons.download_outlined,
                          color: Colors.greenAccent),
                    ),
                    InkWell(
                      onTap: () => entry.isDir
                          ? Get.find<SourceManageController>().listDir(
                          '${Get.find<SourceManageController>().dirController.text}/${entry.name}')
                          : Get.find<SourceManageController>().viewFile(entry.name),
                      child: const Icon(Icons.remove_red_eye_outlined,
                          color: Colors.greenAccent),
                    ),
                    InkWell(
                      onTap: () =>
                          Get.find<SourceManageController>().deleteFile(entry.name),
                      child: const Icon(Icons.delete, color: Colors.red),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget diskItemView(DiskItem e) {
    return InkWell(
      onTap: () => Get.find<SourceManageController>().listDir(e.diskChar),
      child: Container(
          height: 50,
          width: 300,
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(8))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('格式：(${e.ext})-${e.diskName}(${e.diskChar})'),
              Text('可用：${e.size}/总大小：${e.totalSize}')
            ],
          )
      ),
    );
  }
}
