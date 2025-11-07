import 'package:air_quality_app_demo/data/repository.dart';
import 'package:flutter/material.dart';
import 'package:air_quality_app_demo/models/todo_item.dart';

class TodoScreen extends StatelessWidget {
  final Repository repository;

  const TodoScreen({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: const Center(
        child: Text(
          'Hello from TodoScreen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

// class TodoScreen extends StatefulWidget {
//   final RepositoryA repository;

//   const TodoScreen({Key? key, required this.repository}) : super(key: key);

//   @override
//   State<TodoScreen> createState() => _TodoScreenState();
// }

// class _TodoScreenState extends State<TodoScreen> {
//   final ApiService api = ApiService();
//   late Future<List<TodoItem>> todosFuture;

//   @override
//   void initState() {
//     super.initState();
//     todosFuture = api.fetchTodos();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Todo List')),
//       body: FutureBuilder<List<TodoItem>>(
//         future: repository.fetchTodos(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No todos found.'));
//           }

//           final todos = snapshot.data!;
//           return ListView.builder(
//             itemCount: todos.length,
//             itemBuilder: (context, index) {
//               final todo = todos[index];
//               return ListTile(
//                 title: Text(todo.text),
//                 trailing: Icon(
//                   todo.completed ? Icons.check_circle : Icons.circle_outlined,
//                   color: todo.completed ? Colors.green : Colors.grey,
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
