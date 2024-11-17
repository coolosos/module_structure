import 'package:flutter/widgets.dart';
import 'breakpoint.dart';
import 'layout_scope.dart';
import 'package:nested/nested.dart';

export 'layout_scope.dart';

typedef LayoutChildBuilder = Widget Function(
  BuildContext context,
  Widget? child,
  LayoutScope layoutScope,
);

abstract base class Layout extends SingleChildStatelessWidget {
  const Layout({
    super.child,
    super.key,
  });

  LayoutChildBuilder? get small;
  LayoutChildBuilder get medium;
  LayoutChildBuilder? get large;

  bool get apply;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    if (!apply) return child ?? const SizedBox.shrink();

    final layoutScope = LayoutScope.of(context);
    Breakpoint? layoutSize = layoutScope.breakpoint;

    return layoutSize.resolve(
      onL: IO.of((large ?? medium)(context, child, layoutScope)),
      onM: IO.of(medium(context, child, layoutScope)),
      onS: IO.of((small ?? medium)(context, child, layoutScope)),
    );
  }
}
