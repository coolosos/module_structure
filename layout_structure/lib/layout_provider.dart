import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

import 'layout.dart';
import 'layout_scope.dart';

abstract base class LayoutProviderBase extends SingleChildStatelessWidget {
  const LayoutProviderBase({
    super.key,
    super.child,
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
          child: Nested(
            children: layouts,
            child: child,
          ),
        );
      },
    );
  }
}

final class LayoutProvider extends LayoutProviderBase {
  const LayoutProvider({
    required this.layoutList,
    super.key,
    super.child,
  });

  @override
  final List<Layout> layoutList;
}
