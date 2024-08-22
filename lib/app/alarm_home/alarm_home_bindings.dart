import 'package:get/get.dart';
import 'package:sample/app/alarm_home/alarm_home_controller.dart';

class AlarmHomeBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AlarmHomeController());
  }
}
