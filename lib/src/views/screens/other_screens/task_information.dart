import 'package:easy_do/components.dart';
import 'package:easy_do/src/controllers/screen_controllers/task_information_screen_controller.dart';
import 'package:easy_do/src/controllers/services/dev_functions/dev_scaffold.dart';
import 'package:easy_do/src/controllers/services/functions/date_time_conversion.dart';
import 'package:easy_do/src/models/pojo_classes/task_model.dart';
import 'package:easy_do/src/views/widgets/buttons/button_1.dart';
import 'package:easy_do/src/views/widgets/buttons/custom_back_button.dart';
import 'package:easy_do/src/views/widgets/others/custom_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_popup_window_widget/on_popup_window_widget.dart';
import 'package:on_process_button_widget/on_process_button_widget.dart';

class TaskInformationScreen extends StatefulWidget {
  const TaskInformationScreen({super.key, required this.task});
  final TaskModel task;

  @override
  State<TaskInformationScreen> createState() => _TaskInformationScreenState();
}

class _TaskInformationScreenState extends State<TaskInformationScreen> {
  late final TaskInformationScreenController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(TaskInformationScreenController(task: widget.task));
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final dStyle = t.textTheme.labelLarge?.copyWith(color: t.colorScheme.onBackground.withOpacity(0.7), fontWeight: FontWeight.bold, height: 1);
    final borderColor = _controller.task.completed ? t.colorScheme.primary : t.colorScheme.onBackground;
    final iconColor = _controller.task.completed ? t.colorScheme.background : t.colorScheme.onBackground;

    return DevScaffold(
      child: Scaffold(
        appBar: AppBar(
          leading: const CustomBackButtonWidget(),
          title: const Text("Task Details"),
        ),
        body: SafeArea(
          child: LayoutBuilder(builder: (context, box) {
            return RefreshIndicator(
              onRefresh: () async {},
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(minHeight: box.maxHeight + 0.001),
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //! Heading
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //! Title
                                Text(
                                  _controller.task.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: t.textTheme.headlineMedium?.copyWith(color: t.colorScheme.onBackground, fontWeight: FontWeight.bold),
                                ),
                                ____size(4),

                                Row(
                                  children: [
                                    CustomIcon(
                                      Icons.timer_sharp,
                                      size: MediaQuery.textScalerOf(context).scale(dStyle?.fontSize ?? 0),
                                    ),
                                    ____size(4),
                                    Flexible(
                                      child: Text(
                                        _controller.task.dueDate.custom_d_MMM_yyyy_EEE,
                                        style: dStyle,
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: defaultPadding / 4),
                                        padding: EdgeInsets.symmetric(vertical: defaultPadding / 8, horizontal: defaultPadding / 4),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(defaultPadding / 4),
                                          color: _controller.task.completed ? t.colorScheme.primaryContainer : t.colorScheme.errorContainer,
                                        ),
                                        child: Text(
                                          _controller.task.completed ? "Completed" : "Incomplete",
                                          style: dStyle?.copyWith(color: _controller.task.completed ? t.colorScheme.onPrimaryContainer : t.colorScheme.onErrorContainer),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),

                          //! Status Button
                          OnProcessButtonWidget(
                            iconColor: iconColor,
                            height: defaultPadding,
                            width: defaultPadding * 1.5,
                            borderRadius: BorderRadius.circular(defaultPadding / 2),
                            constraints: const BoxConstraints(),
                            contentPadding: EdgeInsets.all(defaultPadding / 8),
                            backgroundColor: borderColor.withOpacity(_controller.task.completed ? 1 : 0.2),
                            border: Border.all(width: borderWidth2, strokeAlign: BorderSide.strokeAlignOutside, color: borderColor.withOpacity(_controller.task.completed ? 1 : 0.7)),
                            onTap: () async {
                              await showDialog(
                                context: context,
                                builder: (context) => OnPopupWindowWidget(
                                  title: Text("Really want to mark as ${_controller.task.completed ? "Incomplete" : "Complete"}"),
                                  footer: OnProcessButtonWidget(
                                    expanded: false,
                                    contentPadding: EdgeInsets.symmetric(horizontal: defaultPadding),
                                    child: const Text("Okay"),
                                  ),
                                  defaultTextAlign: TextAlign.start,
                                  defaultTextStyle: dStyle,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Task: ${_controller.task.title}"),
                                  ),
                                ),
                              );
                              return;
                            },
                            child: FittedBox(child: Icon(Icons.done, color: iconColor)),
                          )
                        ],
                      ),
                      ____size(2),

                      //! Description
                      Button1(
                        borderColor: t.colorScheme.onBackground.withOpacity(0.7),
                        child: Text(
                          _controller.task.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: t.textTheme.bodyLarge?.copyWith(color: t.colorScheme.onBackground),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

Widget ____size([double i = 1]) => SizedBox(height: defaultPadding / i, width: defaultPadding / i);
