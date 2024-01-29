import 'package:easy_do/src/controllers/data_controllers/data_controller.dart';
import 'package:easy_do/src/models/pojo_classes/task_model.dart';
import 'package:get/get.dart';

class TaskInformationScreenController extends GetxController {
  final DataController _controller = Get.find();
  final TaskModel task;

  TaskInformationScreenController({required this.task});

  final RxBool isEditingMode = false.obs;
}
