import 'package:flutter/widgets.dart';

import '../layout.dart';

abstract base class LeftContentLayout extends Layout {
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
  LayoutChildBuilder? get small => null;

  @override
  LayoutChildBuilder get medium => (
        BuildContext context,
        Widget? child,
        LayoutScope layoutScope,
      ) {
        return child ?? const SizedBox();
      };

  @override
  LayoutChildBuilder get large => (
        BuildContext context,
        Widget? child,
        LayoutScope layoutScope,
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
      };
}
