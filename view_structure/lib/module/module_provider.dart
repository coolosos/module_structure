import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

import 'view_module.dart';

base class ModuleProvider<T extends ViewModule>
    extends SingleChildStatelessWidget {
  const ModuleProvider(
    this.module, {
    super.key,
    super.child,
  });
  final T module;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    assert(
      child != null,
      '$runtimeType used outside of MultiModuleProvider must specify a child',
    );
    return _ModuleInherited<T>(
      module: module,
      child: child!,
    );
  }

  static T of<T extends ViewModule>(
    BuildContext context, {
    bool build = false,
  }) {
    final conf = build
        ? context.dependOnInheritedWidgetOfExactType<_ModuleInherited<T>>()
        : context.findAncestorWidgetOfExactType<_ModuleInherited<T>>();

    if (conf == null) {
      throw FlutterError(
        '''
        ModuleProvider.of() called with a context that does not contains a $T.
        
        The widget used was: ${context.widget.runtimeType}.
        ''',
      );
    }

    return conf.module;
  }
}

final class _ModuleInherited<T extends ViewModule> extends InheritedWidget {
  const _ModuleInherited({
    required super.child,
    required this.module,
    super.key,
  });

  final T module;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
