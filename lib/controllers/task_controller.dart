import 'package:roomrai1/db/db_Helper.dart';
import 'package:roomrai1/models/task.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var taskListHistory = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskListHistory
        .assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  void delete(Task task) {
    var val = DBHelper.delete(task);
    print(val);
  }
}
