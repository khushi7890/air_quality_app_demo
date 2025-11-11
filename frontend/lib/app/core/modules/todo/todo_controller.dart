import 'package:get/get.dart';
import 'package:air_quality_app_demo/app/core/models/todo_item.dart';
import 'package:air_quality_app_demo/app/core/data/repository.dart';
import 'package:air_quality_app_demo/app/core/data/services/service_fastapi.dart';

/// Controller responsible for managing ToDo items.
///
/// Communicates with [ServiceFastAPI] via [Repository] to perform
/// CRUD operations on ToDo items.
/// Utilizes a reactive list [todos] that the UI observes for changes.
class TodoController extends GetxController {
  /// FastAPI service instance for backend communication.
  final ServiceFastAPI apiService =
      ServiceFastAPI(baseUrl: "http://10.0.2.2:8000"); // FastAPI service
  /// Reactive list of all ToDo items currently in memory.
  /// Observed by the UI (`Obx`) to automatically rebuild when its contents change.
  var todos = <TodoItem>[].obs;

  /// Lifecycle method called when the controller is first initialized.
  ///
  /// Automatically fetches all ToDo items from the backend.
  @override
  void onInit() {
    super.onInit();
    fetchTodos(); // fetch todos on init
  }

  /// Fetches all ToDo items from the FastAPI backend.
  ///
  /// **Returns:**
  /// A [Future] that completes when the fetch operation finishes.
  ///
  /// **Additional Behavior:**
  /// - Updates the [todos] observable with the latest list of items.
  /// - Triggers UI rebuilds in widgets using `Obx()`.
  ///
  /// **Error handling:**
  /// - Displays a `Get.snackbar` with an error message if the request fails.
  Future<void> fetchTodos() async {
    // fetch todos from backend
    try {
      final fetched =
          await apiService.getTodos(); // use apiService to get todos
      todos.assignAll(fetched);
    } catch (e) {
      // error handling
      Get.snackbar('Error', 'Failed to load todos: $e');
    }
  }

  /// Toggles the completion state of the given [todo].
  ///
  /// **Parameters:**
  /// - [todo]: The [TodoItem] whose `completed` flag should be flipped.
  ///
  /// **Returns:**
  /// A [Future] that completes when the update request finishes.
  ///
  /// **Additional Behavior:**
  /// - Immediately updates the local [todos] list and refreshes it.
  /// - Sends a PUT request to the backend to persist the new state.
  ///
  /// **Error handling:**
  /// - Displays a `Get.snackbar` if the backend update fails.
  void toggleCompletion(TodoItem todo) async {
    final updated = todo.copyWith(
        completed:
            !todo.completed); // Create a new TodoItem, flip completed value

    // Replace the old todo in the list
    final index = todos.indexWhere((t) => t.id == todo.id); //find item by id
    if (index != -1) {
      // if it exists
      todos[index] = updated; //change it
      todos.refresh();
    }

    try {
      await apiService.updateTodo(
          updated.id, updated.toJson()); // send update to backend
    } catch (e) {
      // error handling
      Get.snackbar('Error', 'Could not update todo');
    }
  }

  /// Creates and adds a new ToDo item with the specified [title].
  ///
  /// **Parameters:**
  /// - [title]: The text label or description of the new ToDo.
  ///
  /// **Returns:**
  /// A [Future] that completes when the new ToDo is created on the backend.
  ///
  /// **Side effects:**
  /// - Sends a POST request to create the item.
  /// - Appends the new ToDo to the [todos] list upon success.
  ///
  /// **Error handling:**
  /// - Displays a `Get.snackbar` if the backend request fails.
  void addTodo(String title) async {
    try {
      final newTodo =
          await apiService.createTodo({'title': title, 'completed': false});
      todos.add(newTodo);
    } catch (e) {
      Get.snackbar('Error', 'Could not add todo');
    }
  }
}
