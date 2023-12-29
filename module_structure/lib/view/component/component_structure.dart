import 'package:flutter/widgets.dart';

import 'component_logic.dart';
import 'component_logic_provider.dart';

abstract base class ComponentStructure<CLogic extends ComponentLogic>
    extends StatelessWidget {
  const ComponentStructure({
    required this.pageLogic,
    required this.pageContent,
    super.key,
  });

  final CLogic pageLogic;
  final Widget pageContent;

  static T of<T extends ComponentLogic>(
    BuildContext context, {
    bool build = false,
  }) {
    final pageConfLogic = build
        ? context
            .dependOnInheritedWidgetOfExactType<ComponentLogicProvider<T>>()
        : context.findAncestorWidgetOfExactType<ComponentLogicProvider<T>>();

    if (pageConfLogic == null) {
      throw FlutterError(
        '''
        PageStructure.of() called with a context that does not contains a  .
        
        The widget used was: ${context.widget.runtimeType}.
        ''',
      );
    }

    return pageConfLogic.componentLogic;
  }
}
