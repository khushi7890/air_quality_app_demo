import 'package:get/get.dart';
import 'todo_controller.dart';

/// Initializes dependencies for the To-Do module.
///
/// Lazily (only when something needs it) creates a single [TodoController] instance when first used,
/// which is available to todo_view.dart and other parts of the app.
class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoController>(() => TodoController()); // register controller
  }
}
