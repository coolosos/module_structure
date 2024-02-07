import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'layout.dart';

abstract class BottomContentLayout extends Layout {
  const BottomContentLayout({
    required this.contentSize,
    super.key,
    super.child,
  });

  Widget content(BuildContext context);
  final Size contentSize;

  @override
  bool get apply => kIsWeb;

  @override
  Widget medium(
    BuildContext context,
    Widget? child,
  ) {
    return apply
        ? SingleChildScrollView(
            primary: true,
            child: Column(
              children: [
                SizedBox(height: contentSize.height, child: child),
                content.call(context),
              ],
            ),
          )
        : child ?? const SizedBox();
  }

  @override
  Widget? large(
    BuildContext context,
    Widget? child,
  ) {
    return null;
  }
}
