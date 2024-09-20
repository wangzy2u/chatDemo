import 'package:get/get.dart';

import 'conversation_logic.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConversationLogic());
  }
}
