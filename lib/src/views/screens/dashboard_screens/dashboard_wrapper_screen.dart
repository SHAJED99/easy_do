import 'package:easy_do/components.dart';
import 'package:easy_do/src/controllers/screen_controllers/dashboard_wrapper_screen_controller.dart';
import 'package:easy_do/src/controllers/services/dev_functions/dev_scaffold.dart';
import 'package:easy_do/src/controllers/services/functions/int_conversion.dart';
import 'package:easy_do/src/models/pojo_classes/page_model.dart';
import 'package:easy_do/src/views/widgets/others/custom_size_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardWrapperScreen extends StatefulWidget {
  const DashboardWrapperScreen({super.key});

  @override
  State<DashboardWrapperScreen> createState() => _DashboardWrapperScreenState();
}

class _DashboardWrapperScreenState extends State<DashboardWrapperScreen> {
  final DashboardWrapperScreenController _controller = Get.put(DashboardWrapperScreenController());
  @override
  Widget build(BuildContext context) {
    return DevScaffold(
      child: Scaffold(
        bottomNavigationBar: _BottomNavBar(),
        body: PageView.builder(
          controller: _controller.pageController,
          onPageChanged: (value) => _controller.currentItem.value = value,
          itemCount: _controller.pages.length,
          itemBuilder: (context, index) => _controller.pages.elementAt(index).page,
        ),
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  _BottomNavBar();
  final DashboardWrapperScreenController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).colorScheme.background,
      padding: EdgeInsets.zero,
      // notchMargin: defaultPadding / 4,
      clipBehavior: Clip.antiAlias,
      height: Theme.of(context).buttonTheme.height,
      child: Row(
        children: [
          for (int i in _controller.pages.length.customRange())
            Obx(
              () => Expanded(
                child: InkWell(
                  onTap: () => _controller.changePage(i),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(height: borderWidth1, color: i != _controller.currentItem.value ? null : Theme.of(context).colorScheme.primary),
                      CustomSizeBuilder(
                        constraints: BoxConstraints(maxHeight: defaultPadding / 1.5, maxWidth: defaultPadding / 1.5),
                        child: _controller.pages.elementAt(i).headingIcon,
                      ),
                      SizedBox(height: defaultPadding / 8),
                      Flexible(
                        child: FittedBox(
                            // child: Text(_controller.bottomNavBarList.elementAt(i).pageHeading, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: _setColor(context, i))),
                            ),
                      )
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
