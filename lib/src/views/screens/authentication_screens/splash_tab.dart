import 'package:easy_do/components.dart';
import 'package:easy_do/src/controllers/data_controllers/data_controller.dart';
import 'package:easy_do/src/controllers/services/dev_functions/dev_scaffold.dart';
import 'package:easy_do/src/controllers/services/functions/colors.dart';
import 'package:easy_do/src/views/screens/authentication_screens/login_tab.dart';
import 'package:easy_do/src/views/screens/dashboard_screens/dashboard_wrapper_screen.dart';
import 'package:easy_do/src/views/widgets/others/company_logo.dart';
import 'package:easy_do/src/views/widgets/others/custom_loading_bar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SplashTab extends StatefulWidget {
  const SplashTab({super.key});

  @override
  State<SplashTab> createState() => _SplashTabState();
}

class _SplashTabState extends State<SplashTab> {
  final DataController _controller = Get.find();
  final RxBool isInit = false.obs;
  final RxBool isSplashScreenDone = false.obs;
  final RxBool expandedFields = true.obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initApp());
  }

  String get version => _controller.packageInfo.value?.version ?? "";

  void initApp() {
    _controller.initApp().then((_) {
      isInit.value = true;
      gotoHome();
    });
    Future.delayed(defaultSplashScreenShow).then((_) {
      isSplashScreenDone.value = true;
      gotoHome();
    });
  }

  gotoHome() {
    if (isSplashScreenDone.value && isInit.value) {
      if (_controller.isLogin()) {
        //! TODO: Change Path
        Get.offAll(() => const DashboardWrapperScreen());
        // expandedFields.value = false;
      } else {
        // if (resetFields != null) resetFields!();
        expandedFields.value = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DevScaffold(
      child: Scaffold(
        body: Obx(
          () => Stack(
            children: [
              LayoutBuilder(builder: (context, box) {
                final height = box.maxHeight;
                final theme = Theme.of(context);

                return SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Container(
                    constraints: BoxConstraints(minHeight: box.maxHeight),
                    child: Obx(
                      () => Column(
                        children: [
                          //! Top Logo
                          AnimatedContainer(
                            alignment: Alignment.center,
                            duration: defaultDuration,
                            height: expandedFields.value ? height : height / 4,
                            constraints: BoxConstraints(minHeight: theme.buttonTheme.height * 2 + (defaultPadding * 2)),
                            padding: EdgeInsets.only(
                              bottom: defaultPadding,
                              top: defaultPadding + (!expandedFields.value ? defaultPadding : MediaQuery.of(context).padding.top),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: expandedFields.value ? null : BorderRadius.vertical(bottom: Radius.circular(defaultPadding)),
                              gradient: LinearGradient(colors: theme.brightness == Brightness.light ? defaultGradient : defaultGradient.map((e) => e.customInverseColor).toList(), begin: Alignment.topLeft, end: Alignment.bottomRight),
                            ),
                            child: const _Logo(),
                          ),

                          //! Input fields
                          if (!expandedFields.value) LoginTab(box),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              if (expandedFields.value) Positioned(bottom: defaultPadding, left: 0, right: 0, child: _AppVersion(version)),
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return const FittedBox(
      child: CompanyLogo(),
    );
  }
}

class _AppVersion extends StatelessWidget {
  const _AppVersion(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomCircularProgressBar(),
        ____size(2),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onBackground),
        )
      ],
    );
  }
}

Widget ____size([double i = 1]) => SizedBox(height: defaultPadding / i, width: defaultPadding / i);
