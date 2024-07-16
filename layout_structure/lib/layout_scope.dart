import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';
import 'breakpoint.dart';
import 'layout.dart';
import 'package:collection/collection.dart';

class LayoutScope extends InheritedWidget {
  LayoutScope({
    required Widget child,
    required this.constraints,
    required this.layouts,
    super.key,
  }) : super(
          child: child = Nested(
            children: layouts,
            child: child,
          ),
        );

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

  Breakpoint get breakpoint => Breakpoint.breakpointOf(constraints.maxWidth);

  bool isSideApplied<T extends Layout>() =>
      _getLayoutFromList<T>()?.apply ?? false;

  bool isSideDefined<T extends Layout>() => _getLayoutFromList<T>() != null;

  @override
  bool updateShouldNotify(LayoutScope oldWidget) => true;

  Layout? _getLayoutFromList<T extends Layout>() => layouts.firstWhereOrNull(
        (layout) => layout.runtimeType == T,
      );
}
