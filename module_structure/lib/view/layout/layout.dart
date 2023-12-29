import 'package:flutter/widgets.dart';
import '../../functional.dart';
import 'breakpoint.dart';
import 'layout_scope.dart';
import 'package:nested/nested.dart';

abstract class Layout extends SingleChildStatelessWidget {
  const Layout({
    super.child,
    super.key,
  });

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
    final Widget? content =
        child != null ? KeyedSubtree(key: GlobalKey(), child: child) : child;

    Breakpoint? layoutSize = LayoutScope.breakpointOf(context);

    return layoutSize.resolveFirstInstance(
      onL: IO(() => large(context, content) ?? medium(context, content)),
      onDefault: IO(() => medium(context, content)),
    );
  }
}

extension BreakpointLayout on Breakpoint {
  T resolveFirstInstance<T>({
    required IO<T> onL,
    required IO<T> onDefault,
  }) {
    final io = switch (this) {
      Breakpoint.l => onL,
      Breakpoint.s => onDefault,
      Breakpoint.m => onDefault,
    };
    return io.run();
  }
}
