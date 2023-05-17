import 'package:get/get.dart';

class HomeController extends GetxController {
  void logout() {
    Get.offAllNamed('/sign-in');
  }

  void create() {
    Get.toNamed('/create');
  }
}
