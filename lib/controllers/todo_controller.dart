import 'package:get/state_manager.dart';
import 'package:todo_app_assignment/models/todo.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;

  addTask(String title, String description, String createdAt) {
    tasks.add(Task(title, description, createdAt));
  }

  deleteTask(int index) {
    tasks.removeAt(index);
  }

  String? validateInput(String input) {
    if (input.isEmpty) {
      return 'Task cannot be empty';
    }
    return null;
  }
}
