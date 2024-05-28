library component_logic;

import 'component_events.dart';
import 'component_navigation.dart';
import 'notification_scroll_listener.dart';

abstract interface class ComponentLogic {
  /// A event form scroll update notification
  NotificationUpdateListenerCallback? get scrollNotificationEvent;

  ///Navigation of component.
  ///
  ///Usually create for extract the logic of navigation.
  ///Would have navigation logic and checks.
  ComponentNavigation? get navigation;

  ///View events
  ///
  ///Usually manage taps, drags and other callable functions
  ComponentEvents? get events;
}
