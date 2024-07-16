import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

import 'layout.dart';

abstract base class LayoutProviderBase extends SingleChildStatelessWidget {
  const LayoutProviderBase({
    required super.child,
    super.key,
  });

  List<Layout> get layoutList;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    final List<Layout> layouts = layoutList;

    return LayoutBuilder(
      builder: (context, constraints) {
        return LayoutScope(
          layouts: layouts,
          constraints: constraints,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}

final class LayoutProvider extends LayoutProviderBase {
  const LayoutProvider({
    required this.layoutList,
    required super.child,
    super.key,
  });

  @override
  final List<Layout> layoutList;
}
