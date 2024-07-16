import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../layout.dart';

abstract base class BottomContentLayout extends Layout {
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
  LayoutChildBuilder? get small => null;

  @override
  LayoutChildBuilder get medium => (
        BuildContext context,
        Widget? child,
        LayoutScope layoutScope,
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
      };

  @override
  LayoutChildBuilder? get large => null;
}
