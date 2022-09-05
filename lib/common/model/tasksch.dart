import 'dart:convert';

class TaskSch{

  late String task_name;

  late int task_hours;

  late String exec_path;

  TaskSch(this.task_name, this.task_hours, this.exec_path);

  String toJson() {
    final map = <String, dynamic>{};
    map['task_name'] = task_name;
    map['task_hours'] = task_hours;
    map['exec_path'] = exec_path;
    return json.encode(map);
  }

}