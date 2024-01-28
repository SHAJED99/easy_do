import 'package:easy_do/components.dart';
import 'package:easy_do/src/controllers/screen_controllers/dashboard_wrapper_screen_controller.dart';
import 'package:easy_do/src/controllers/services/dev_functions/dev_scaffold.dart';
import 'package:easy_do/src/controllers/services/functions/int_conversion.dart';
import 'package:easy_do/src/models/pojo_classes/page_model.dart';
import 'package:easy_do/src/views/widgets/others/custom_size_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.all(defaultPadding / 2),
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller.pageController,
              onPageChanged: (value) => _controller.currentItem.value = value,
              itemCount: _controller.pages.length,
              itemBuilder: (context, index) => _controller.pages.elementAt(index).page,
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  _BottomNavBar();
  final DashboardWrapperScreenController _controller = Get.find();
  Color _setColor(BuildContext context, int index, {bool isBar = false}) => _controller.currentItem.value == index ? Theme.of(context).colorScheme.primary : (isBar ? Colors.transparent : Theme.of(context).colorScheme.onBackground);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: defaultPadding,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        children: [
          for (int i in _controller.pages.length.customRange())
            Obx(
              () => Expanded(
                child: InkWell(
                  onTap: () => _controller.changePage(i),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        height: borderWidth2,
                        constraints: BoxConstraints(maxWidth: Theme.of(context).buttonTheme.height),
                        duration: defaultDuration,
                        color: _setColor(context, i, isBar: true),
                      ),
                      SizedBox(height: defaultPadding / 2),
                      CustomSizeBuilder(
                        constraints: BoxConstraints(maxHeight: defaultPadding, maxWidth: defaultPadding),
                        child: _controller.pages.elementAt(i).headingIcon ??
                            (_controller.pages.elementAt(i).svg.isEmpty
                                ? const SizedBox()
                                : SvgPicture.asset(
                                    _controller.pages.elementAt(i).svg,
                                    colorFilter: ColorFilter.mode(_setColor(context, i), BlendMode.srcIn),
                                  )),
                      ),
                      SizedBox(height: defaultPadding / 8),
                      Flexible(
                        child: FittedBox(
                          child: Text(_controller.pages.elementAt(i).pageHeading, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: _setColor(context, i))),
                        ),
                      ),
                      SizedBox(height: (defaultPadding / 2) + MediaQuery.of(context).padding.bottom),
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
