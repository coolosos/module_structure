import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../layout.dart';

abstract class ContentLayout extends Layout {
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
  Widget? small(
    BuildContext context,
    Widget? child,
  ) {
    return child;
  }

  @override
  Widget medium(
    BuildContext context,
    Widget? child,
  ) =>
      child != null
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

  @override
  Widget? large(
    BuildContext context,
    Widget? child,
  ) =>
      medium(context, child);
}
