// CHAT GPT GENERATED STUB TO VERIFY CONTROLLER LOGIC AND BACKEND TIE - CHANGE LATER

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'todo_controller.dart';
import 'package:air_quality_app_demo/app/core/routes/app_routes.dart';

class TodoView extends GetView<TodoController> {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController newTodoController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.fetchTodos,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.todos.isEmpty) {
          return const Center(child: Text('No todos yet.'));
        }
        return ListView.builder(
          itemCount: controller.todos.length,
          itemBuilder: (context, index) {
            final todo = controller.todos[index];
            return ListTile(
              leading: Checkbox(
                value: todo.completed,
                onChanged: (_) => controller.toggleCompletion(todo),
              ),
              title: Text(
                todo.text,
                style: TextStyle(
                  decoration:
                      todo.completed ? TextDecoration.lineThrough : null,
                  color: todo.completed ? Colors.grey : null,
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'add_todo', // unique tag to avoid animation conflicts
            onPressed: () {
              Get.defaultDialog(
                title: 'Add ToDo',
                content: TextField(
                  controller: newTodoController,
                  decoration:
                      const InputDecoration(hintText: 'Enter todo title'),
                ),
                textConfirm: 'Add',
                textCancel: 'Cancel',
                onConfirm: () {
                  if (newTodoController.text.trim().isNotEmpty) {
                    controller.addTodo(newTodoController.text.trim());
                  }
                  Get.back();
                  newTodoController.clear();
                },
              );
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            onPressed: () => Get.offNamed(Routes.home),
            child: const Icon(Icons.home),
          ),
        ],
      ),
    );
  }
}
