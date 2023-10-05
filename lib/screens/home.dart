import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:todo_app_assignment/controllers/todo_controller.dart';
import 'package:todo_app_assignment/utilities/colors.dart';
import 'package:todo_app_assignment/widgets/button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskController taskController = Get.put(TaskController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController createdAtController = TextEditingController();
  String? _errorText;

  void _validateInput(String input) {
    if (input.isEmpty || input == '') {
      setState(() {
        _errorText = 'Please enter a title';
      });
    }
  }

  void _addTask() {
    final task = titleController.text.trim();
    final description = titleController.text.trim();
    final createdAt = createdAtController.text.trim();
    if (task.isNotEmpty) {
      taskController.addTask(task, description, createdAt);
      titleController.clear();
      Navigator.of(context).pop();
    }
  }

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade400,
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: [
            Button(
              onPressed: () {
                taskController.deleteTask(index);
                Navigator.of(context).pop();
              },
              title: 'Yes',
            ),
            Button(
              onPressed: () {
                Navigator.of(context).pop();
              },
              title: 'No',
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'ToDo App with GetX',
          style: TextStyle(
            color: Colors.grey.shade300,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Obx(
              () {
                if (taskController.tasks.isEmpty) {
                  return Center(
                    child: Text(
                      'No tasks yet. Add a new task!',
                      style: TextStyle(
                          fontSize: 18.0, color: Colors.grey.shade300),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: taskController.tasks.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          title: Text(
                            taskController.tasks[index].title,
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _showDeleteConfirmationDialog(index);
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade400,
        foregroundColor: bgColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.grey.shade400,
                title: const Text('Add a New Task'),
                content: TextField(
                  controller: titleController,
                  onChanged: _validateInput,
                  cursorColor: bgColor,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: bgColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: bgColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorText: _errorText,
                    hintText: 'Enter your task',
                  ),
                ),
                actions: [
                  Button(
                      onPressed: () {
                        _addTask();
                      },
                      title: 'Add'),
                  Button(
                      onPressed: () {
                        titleController.clear();
                        Navigator.of(context).pop();
                      },
                      title: 'Cancel'),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
