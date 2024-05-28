import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

import 'view_module.dart';

final class ModuleProvider<T extends ViewModule>
    extends SingleChildStatelessWidget {
  const ModuleProvider(
    this.component, {
    super.key,
    super.child,
  });
  final T component;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    assert(
      child != null,
      '$runtimeType used outside of ModuleProvider must specify a child',
    );
    return _ComponentInherited<T>(
      component: component,
      child: child!,
    );
  }

  static T of<T extends ViewModule>(
    BuildContext context, {
    bool build = false,
  }) {
    final conf = build
        ? context.dependOnInheritedWidgetOfExactType<_ComponentInherited<T>>()
        : context.findAncestorWidgetOfExactType<_ComponentInherited<T>>();

    if (conf == null) {
      throw FlutterError(
        '''
        Component.of() called with a context that does not contains a $T.
        
        The widget used was: ${context.widget.runtimeType}.
        ''',
      );
    }

    return conf.component;
  }
}

final class _ComponentInherited<T extends ViewModule> extends InheritedWidget {
  const _ComponentInherited({
    required super.child,
    required this.component,
    super.key,
  });

  final T component;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
