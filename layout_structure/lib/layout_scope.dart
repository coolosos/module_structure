import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';
import 'breakpoint.dart';
import 'layout.dart';
import 'package:collection/collection.dart';

class LayoutScope extends InheritedWidget {
  const LayoutScope({
    required super.child,
    required this.constraints,
    required this.layouts,
    super.key,
  });
  final List<Layout> layouts;
  final BoxConstraints constraints;

  static LayoutScope of(BuildContext context) {
    final LayoutScope? layoutScope =
        context.dependOnInheritedWidgetOfExactType<LayoutScope>();

    if (layoutScope == null) {
      throw throw FlutterError('''
        LayoutScope.of() called with a context that does not contain a LayoutScope.
        
        The widget used was: LayoutScope.
        ''');
    }

    return layoutScope;
  }

  static Breakpoint breakpointOf(BuildContext context) =>
      Breakpoint.breakpointOf(of(context).constraints.maxWidth);

  bool isSideApplied<T extends Layout>() =>
      _getLayoutFromList()?.apply ?? false;

  bool isSideDefined<T extends Layout>() => _getLayoutFromList() != null;

  @override
  bool updateShouldNotify(LayoutScope oldWidget) => true;

  Layout? _getLayoutFromList<T extends Layout>() => layouts.firstWhereOrNull(
        (layout) => layout.runtimeType == T,
      );

  static Widget provide({
    required Widget? child,
    required List<Layout> layoutList,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return LayoutScope(
          layouts: layoutList,
          constraints: constraints,
          child: Nested(
            children: layoutList,
            child: child,
          ),
        );
      },
    );
  }
}
