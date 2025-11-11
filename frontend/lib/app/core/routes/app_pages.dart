import 'package:get/get.dart';
import 'package:air_quality_app_demo/app/core/modules/home/home_view.dart';
import 'package:air_quality_app_demo/app/core/modules/home/home_binding.dart';
import 'package:air_quality_app_demo/app/core/modules/todo/todo_binding.dart';
import 'package:air_quality_app_demo/app/core/modules/todo/todo_view.dart';
import 'app_routes.dart';

import 'package:air_quality_app_demo/app/core/modules/home/home_binding.dart';

class AppPages {
  AppPages._();

  // Initial route when the app launches
  static const initial = Routes.home;

  static final routes = [
    // home page
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    // todo page
    GetPage(
      name: Routes.todo,
      page: () => const TodoView(),
      binding: TodoBinding(),
    ),
  ];
}
