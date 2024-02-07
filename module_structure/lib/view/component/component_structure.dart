import 'package:flutter/widgets.dart';
import 'notification_scroll_listener.dart';
import 'package:nested/nested.dart';

import 'component_layout.dart';
import 'component_logic.dart';
import 'component_logic_provider.dart';

abstract base class ComponentStructure<CLogic extends ComponentLogic>
    extends StatelessWidget {
  const ComponentStructure({
    required this.componentLogic,
    required this.componentContent,
    this.pageLayout,
    super.key,
  });

  final CLogic componentLogic;
  final Widget componentContent;
  final ComponentLayout? pageLayout;

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
    return Nested(
      child: ComponentLogicProvider<CLogic>(
        componentLogic: componentLogic,
        child: pageLayout != null
            ? Nested(
                child: componentContent,
                children: [
                  pageLayout!,
                ],
              )
            : componentContent,
      ),
      children: [
        if (componentLogic.scrollNotificationEvent
            is NotificationUpdateListenerCallback)
          NotificationScrollListener(
            notificationEvent: componentLogic.scrollNotificationEvent!,
          ),
      ],
    );
  }
}
