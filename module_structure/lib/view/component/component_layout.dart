import 'package:flutter/widgets.dart';
import '../layout/layout.dart';
import 'package:nested/nested.dart';

import '../layout/layout_scope.dart';

abstract base class ComponentLayout extends SingleChildStatelessWidget {
  const ComponentLayout({
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
          layoutList: layouts,
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
