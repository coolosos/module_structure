library component_logic;

import 'component_events.dart';
import 'component_navigations.dart';
import 'notification_scroll_listener.dart';

abstract interface class ComponentLogic {
  /// A event form scroll update notification
  NotificationUpdateListenerCallback? get scrollNotificationEvent;

  ///Navigation of component.
  ///
  ///Usually create for extract the logic of navigations.
  ///Would have navigation logic and checks.
  ComponentNavigations? get externalNavigations;

  ///View events
  ///
  ///Usually manage taps, drags and other callable functions
  ComponentEvents? get events;
}
