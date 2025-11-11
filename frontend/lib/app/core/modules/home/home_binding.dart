import 'package:get/get.dart';
import 'package:air_quality_app_demo/app/core/data/services/service_fastapi.dart';
import 'package:air_quality_app_demo/app/core/data/services/service_firestore.dart';
import 'package:air_quality_app_demo/app/core/data/repository.dart';
import 'package:air_quality_app_demo/app/core/modules/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Register FastAPI service
    Get.lazyPut<ServiceFastAPI>(
        () => ServiceFastAPI(baseUrl: "http://0.0.2.2:8000"));

    // Register Firestore service
    Get.lazyPut<ServiceFirestore>(() => ServiceFirestore());

    // Register Repository that uses both FastAPI and Firestore
    Get.lazyPut<Repository>(
      () => Repository(
        fastAPI: Get.find<ServiceFastAPI>(),
        firestore: Get.find<ServiceFirestore>(),
      ),
    );

    // Register controller
    Get.lazyPut<HomeController>(
      () => HomeController(Get.find<Repository>()),
    );
  }
}

// import 'package:get/get.dart';
// import 'package:air_quality_app_demo/app/core/data/services/service_firestore.dart';
// import 'package:air_quality_app_demo/app/core/data/repository.dart';
// import 'package:air_quality_app_demo/app/core/modules/home/home_controller.dart';

// class HomeBinding extends Bindings {
//   @override
//   void dependencies() {
//     // Register Firestore service
//     Get.lazyPut<ServiceFirestore>(() => ServiceFirestore());

//     // Register Repository that uses Firestore
//     Get.lazyPut<Repository>(
//       () => Repository(
//         fastAPI: Get.find(), // only if you already registered it
//         firestore: Get.find(),
//       ),
//     );

//     // Register controller
//     Get.lazyPut<HomeController>(() => HomeController(Get.find<Repository>()));
//   }
// }
