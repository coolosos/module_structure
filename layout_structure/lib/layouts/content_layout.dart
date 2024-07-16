import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../layout.dart';

abstract base class ContentLayout extends Layout {
  const ContentLayout({
    required this.constraints,
    super.child,
    super.key,
  });

  Decoration decoration(BuildContext context);
  final BoxConstraints constraints;

  @override
  bool get apply => true;

  @override
  LayoutChildBuilder get large => (
        BuildContext context,
        Widget? child,
        LayoutScope layoutScope,
      ) {
        return child != null
            ? DecoratedBox(
                decoration: decoration.call(context),
                child: Center(
                  child: ConstrainedBox(
                    constraints: constraints,
                    child: child,
                  ),
                ),
              )
            : const SizedBox.shrink();
      };
}
