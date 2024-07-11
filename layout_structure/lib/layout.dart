import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'breakpoint.dart';
import 'layout_scope.dart';
import 'package:nested/nested.dart';

abstract class Layout extends SingleChildStatelessWidget {
  const Layout({
    super.child,
    super.key,
  });

  Widget? small(
    BuildContext context,
    Widget? child,
  );
  Widget medium(
    BuildContext context,
    Widget? child,
  );
  Widget? large(
    BuildContext context,
    Widget? child,
  );

  bool get apply;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    if (!apply) return child ?? const SizedBox.shrink();
    final Widget? content =
        child != null ? KeyedSubtree(key: GlobalKey(), child: child) : child;

    Breakpoint? layoutSize = LayoutScope.breakpointOf(context);

    return layoutSize.resolve(
      onL: IO(() => large(context, content) ?? medium(context, content)),
      onM: IO(() => medium(context, content)),
      onS: IO(() => small(context, content) ?? medium(context, content)),
    );
  }
}
