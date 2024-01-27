import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:on_process_button_widget/on_process_button_widget.dart';

class DevAutoFillButton extends StatelessWidget {
  const DevAutoFillButton({super.key, this.onPressed = const []});
  final List<Function> onPressed;

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) return const SizedBox();

    // return FloatingActionButton.small(
    //   onPressed: onPressed,
    //   child: Text(
    //     "DEV",
    //     style: Theme.of(context).textTheme.titleSmall,
    //   ),
    // );

    return Row(
      children: [
        for (int i = 0; i < onPressed.length; i++)
          OnProcessButtonWidget(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            alignment: Alignment.center,
            constraints: const BoxConstraints(minHeight: 24 * 1.5, maxWidth: 24 * 1.5),
            contentPadding: EdgeInsets.zero,
            onTap: () => onPressed.elementAt(i)(),
            child: Text(i.toString()),
          )
      ],
    );
  }
}
