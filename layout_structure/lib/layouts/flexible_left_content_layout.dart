import 'package:flutter/material.dart';

import '../layout.dart';

abstract base class FlexibleContentLayout extends Layout {
  const FlexibleContentLayout({
    super.child,
    super.key,
  });

  Widget content(BuildContext context);

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
        SizedBox(
          width: 420,
          child: content.call(context),
        ),
        if (child != null) Expanded(child: child),
      ],
    );
  }
}
