import 'package:easy_do/components.dart';
import 'package:easy_do/src/controllers/screen_controllers/dashboard_wrapper_screen_controller.dart';
import 'package:easy_do/src/controllers/services/functions/colors.dart';
import 'package:easy_do/src/controllers/services/functions/date_time_conversion.dart';
import 'package:easy_do/src/controllers/services/functions/int_conversion.dart';
import 'package:easy_do/src/controllers/services/functions/string_formatter.dart';
import 'package:easy_do/src/models/pojo_classes/task_model.dart';
import 'package:easy_do/src/views/widgets/buttons/button_1.dart';
import 'package:easy_do/src/views/widgets/others/custom_icon.dart';
import 'package:easy_do/src/views/widgets/others/custom_loading_bar.dart';
import 'package:easy_do/src/views/widgets/others/custom_size_builder.dart';
import 'package:easy_do/src/views/widgets/others/dashboard_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final DashboardWrapperScreenController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final tC = t.colorScheme.onBackground;

    return LayoutBuilder(builder: (context, box1) {
      return Obx(() {
        return RefreshIndicator(
          onRefresh: () async => await _controller.getData(),
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(minHeight: box1.maxHeight + 0.001),
              padding: EdgeInsets.all(defaultPadding / 2),
              child: _controller.isLoading.value && (_controller.response.value == null || _controller.response.value!.data.isEmpty)
                  ? const CustomSizeBuilder(child: CustomCircularProgressBar())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //! Heading
                        Text("Hello!", style: t.textTheme.displaySmall?.copyWith(color: tC, fontWeight: FontWeight.bold)),
                        Text("What's your plan for today?", style: t.textTheme.bodyLarge?.copyWith(color: tC)),
                        ____size(),

                        //! Task Summary
                        const CustomTitle("Task Summary"),
                        ____size(2),
                        LayoutBuilder(
                          builder: (context, box2) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  _TaskSummaryTile(box: box2, completed: false),
                                  ____size(2),
                                  _TaskSummaryTile(box: box2, completed: true),
                                ],
                              ),
                            );
                          },
                        ),
                        ____size(),

                        //! Tasks for the Day
                        const CustomTitle("Tasks for the Day"),
                        ____size(2),
                        for (TaskModel t in _controller.response.value?.data ?? []) _TaskCardTile(task: t)
                      ],
                    ),
            ),
          ),
        );
      });
    });
  }
}

Widget ____size([double i = 1]) => SizedBox(height: defaultPadding / i, width: defaultPadding / i);

class _TaskSummaryTile extends StatelessWidget {
  _TaskSummaryTile({required this.box, required this.completed});

  final DashboardWrapperScreenController _controller = Get.find();

  final BoxConstraints box;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);

    return Button1(
      backgroundImage: "lib/assets/card_image/${completed ? "complete" : "incomplete"}.png",
      width: (box.maxWidth / 2) - (defaultPadding / 2),
      constraints: BoxConstraints(minWidth: maxBoxWidth / 2, minHeight: Theme.of(context).buttonTheme.height * 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            t.colorScheme.background.withOpacity(1),
            t.colorScheme.background.withOpacity(0.7),
            t.colorScheme.background.withOpacity(0.3),
            t.colorScheme.background.withOpacity(0.1),
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(completed ? "Completed" : "Incomplete", style: t.textTheme.bodyLarge?.copyWith(color: t.colorScheme.onBackground, fontWeight: FontWeight.bold)),
          Text(
            (completed ? _controller.response.value?.totalComplete : _controller.response.value?.totalIncomplete).toString(),
            style: t.textTheme.displaySmall?.copyWith(
              color: t.colorScheme.onBackground,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

class _TaskCardTile extends StatelessWidget {
  const _TaskCardTile({required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final dStyle = t.textTheme.labelLarge?.copyWith(color: t.colorScheme.onBackground.withOpacity(0.7), fontWeight: FontWeight.bold, height: 1);

    return Button1(
      margin: EdgeInsets.only(bottom: defaultPadding / 4),
      color: t.colorScheme.background,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //! Title
                    Text(
                      task.title,
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
                            task.dueDate.custom_d_MMM_yyyy_EEE,
                            style: dStyle,
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 4),
                            padding: EdgeInsets.symmetric(vertical: defaultPadding / 8, horizontal: defaultPadding / 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(defaultPadding / 4),
                              color: task.completed ? t.colorScheme.primaryContainer : t.colorScheme.errorContainer,
                            ),
                            child: Text(
                              task.completed ? "Completed" : "Incomplete",
                              style: dStyle?.copyWith(color: task.completed ? t.colorScheme.onPrimaryContainer : t.colorScheme.onErrorContainer),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Task Summary
