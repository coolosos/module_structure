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
  LayoutChildBuilder? get small => null;

  @override
  LayoutChildBuilder get medium => (
        BuildContext context,
        Widget? child,
        LayoutScope layoutScope,
      ) {
        return child ?? const SizedBox.shrink();
      };

  @override
  LayoutChildBuilder get large => (
        BuildContext context,
        Widget? child,
        LayoutScope layoutScope,
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
      };
}
