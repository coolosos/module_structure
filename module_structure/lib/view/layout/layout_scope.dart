import 'package:flutter/widgets.dart';
import 'breakpoint.dart';
import 'layout.dart';
import 'package:collection/collection.dart';

class LayoutScope extends InheritedWidget {
  const LayoutScope({
    required super.child,
    required this.constraints,
    required this.layoutList,
    super.key,
  });
  final List<Layout> layoutList;
  final BoxConstraints constraints;

  static LayoutScope maybeOf(BuildContext context) {
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

  static Breakpoint breakpointOf(BuildContext context) {
    final LayoutScope result = maybeOf(context);
    final double maxWidth = result.constraints.maxWidth;

    return Breakpoint.sortedValues.firstWhere(
      (bp) => maxWidth >= bp.width,
      orElse: () => Breakpoint.s,
    );
  }

  bool isSideAplied<T extends Layout>() {
    final layout = _getLayoutFromList();

    return layout?.apply ?? false;
  }

  bool isSideDefined<T extends Layout>() {
    return _getLayoutFromList() != null;
  }

  @override
  bool updateShouldNotify(LayoutScope oldWidget) {
    return true;
  }

  Layout? _getLayoutFromList<T extends Layout>() {
    List<Layout>? layoutList = this.layoutList;

    final layout = layoutList.firstWhereOrNull(
      (element) => element.runtimeType == T,
    );
    return layout;
  }
}
