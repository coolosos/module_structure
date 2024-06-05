import 'package:flutter/widgets.dart';

import '../layout.dart';

abstract class LeftContentLayout extends Layout {
  const LeftContentLayout({
    required this.contentSize,
    super.child,
    super.key,
  });

  Widget content(BuildContext context);
  final Size contentSize;

  @override
  bool get apply => true;

  @override
  Widget? small(
    BuildContext context,
    Widget? child,
  ) {
    return null;
  }

  @override
  Widget medium(
    BuildContext context,
    Widget? child,
  ) {
    return child ?? const SizedBox();
  }

  @override
  Widget? large(
    BuildContext context,
    Widget? child,
  ) {
    return Row(
      children: [
        content.call(context),
        SizedBox(
          width: contentSize.width,
          child: child,
        ),
      ],
    );
  }
}
