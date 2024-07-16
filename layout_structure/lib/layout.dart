import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
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
    final Widget? content =
        child != null ? KeyedSubtree(key: GlobalKey(), child: child) : child;

    final layoutScope = LayoutScope.of(context);
    Breakpoint? layoutSize = layoutScope.breakpoint;

    return layoutSize.resolve(
      onL: IO(
        () => (large ?? medium).call(context, content, layoutScope),
      ),
      onM: IO(() => medium(context, content, layoutScope)),
      onS: IO(
        () => (small ?? medium).call(context, content, layoutScope),
      ),
    );
  }
}
