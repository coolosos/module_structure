import 'package:flutter/widgets.dart';
import 'notification_scroll_listener.dart';
import 'package:nested/nested.dart';

import 'component_logic.dart';
import 'component_logic_provider.dart';

abstract base class ComponentStructure<CLogic extends ComponentLogic>
    extends StatelessWidget {
  const ComponentStructure({
    required this.componentLogic,
    required this.componentContent,
    super.key,
  });

  final CLogic componentLogic;
  final Widget componentContent;

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

  @override
  Widget build(BuildContext context) {
    final scrollNotificationChild = componentLogic.scrollNotificationEvent;

    if (scrollNotificationChild is NotificationUpdateListenerCallback) {
      return Nested(
        child: ComponentLogicProvider<CLogic>(
          componentLogic: componentLogic,
          child: componentContent,
        ),
        children: [
          NotificationScrollListener(
            notificationEvent: scrollNotificationChild,
          ),
        ],
      );
    }

    return ComponentLogicProvider<CLogic>(
      componentLogic: componentLogic,
      child: componentContent,
    );
  }
}
