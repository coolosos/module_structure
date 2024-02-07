import 'package:flutter/widgets.dart';

import 'component_logic.dart';

class ComponentLogicProvider<T extends ComponentLogic> extends InheritedWidget {
  const ComponentLogicProvider({
    required super.child,
    required this.componentLogic,
    super.key,
  });

  final T componentLogic;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
