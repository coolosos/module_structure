import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

typedef NotificationUpdateListenerCallback = void Function(
  BuildContext context,
  ScrollUpdateNotification notification,
  double percent,
);

class NotificationScrollListener extends SingleChildStatelessWidget {
  const NotificationScrollListener({
    required this.notificationEvent,
    super.key,
  });

  final NotificationUpdateListenerCallback notificationEvent;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          var percent = notification.metrics.pixels /
              notification.metrics.maxScrollExtent;

          notificationEvent.call(context, notification, percent);
        }
        return false;
      },
      child: child ?? const SizedBox.shrink(),
    );
  }
}
