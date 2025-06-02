import 'package:flutter/widgets.dart';
import 'breakpoint.dart';
import 'layout_scope.dart';
import 'package:nested/nested.dart';

export 'layout_scope.dart';

typedef LayoutChildBuilder = Widget Function(
  BuildContext context,
  Widget? child,
  LayoutScope scope,
);

/// Abstract base class for layout widgets that adapt based on breakpoints.
///
/// This class provides the structure for building a responsive widget based
/// on a given [Breakpoint]. Subclasses must implement [layoutChildBuilder]
/// to define how the layout should adapt depending on the current context.
abstract base class LayoutBase extends SingleChildStatelessWidget {
  const LayoutBase({required super.child, super.key});

  /// Determines whether the layout logic should be applied.
  ///
  /// If false, the layout will not be built and the original child will be returned as-is.
  bool get apply;

  /// Builds the appropriate layout widget based on the current [breakpoint].
  ///
  /// Must Find the first matching [Range].
  Widget layoutChildBuilder(
    BuildContext context, {
    required Widget? child,
    required Breakpoint breakpoint,
    required LayoutScope scope,
  });

  /// Builds the widget tree using the selected layout strategy.
  ///
  /// If [apply] is false, returns the original child directly (or an empty [SizedBox] if null).
  /// Otherwise, delegates the layout logic to [layoutChildBuilder] using the current [LayoutScope].

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    if (!apply) return child ?? const SizedBox.shrink();

    final layoutScope = LayoutScope.of(context);

    return layoutChildBuilder(
      context,
      child: child,
      breakpoint: layoutScope.breakpoint,
      scope: layoutScope,
    );
  }
}

/// Abstract base class for layout widgets that depend on specific width ranges.
///
/// This class maps a set of [Range] objects to layout builders, and based on
/// the current breakpoint, chooses the appropriate builder to construct the child.
///
/// Validations are performed in the constructor to ensure that:
/// - At least one range is defined.
/// - No duplicate ranges exist.
/// - No overlapping ranges are allowed.
abstract base class LayoutRange extends LayoutBase {
  LayoutRange({required super.child, super.key}) {
    final entries = ranges.entries;

    // Ensure at least one range is defined.
    if (entries.isEmpty) {
      throw UnsupportedError(
        'LayoutRange must have at least one range for iterate',
      );
    }

    final values = ranges.values;

    // Ensure there are no duplicate range values.
    if (values.toSet().length != values.length) {
      throw UnsupportedError(
        'There are are equals ranges',
      );
    }

    // Ensure ranges do not overlap.
    if (hasOverlaps(ranges.keys)) {
      throw UnsupportedError(
        'There are overlaps',
      );
    }

    _rangeEntries = entries;
  }

  /// Checks whether any of the provided ranges overlap with each other.
  ///
  /// Ranges are first sorted by minimum width, then each range is compared with
  /// the previous one to detect overlap.
  static bool hasOverlaps(Iterable<Range> ranges) {
    if (ranges.length < 2) return false;

    final sorted = List<Range>.from(ranges)
      ..sort((a, b) => a.minWidth.compareTo(b.minWidth));

    for (int i = 1; i < sorted.length; i++) {
      final prev = sorted[i - 1];
      final current = sorted[i];

      if (current.overlaps(prev)) {
        return true;
      }
    }

    return false;
  }

  /// Whether this layout should be applied based on current context.
  ///
  /// Must be implemented by subclasses to indicate when the layout is active.
  @override
  bool get apply;

  /// Defines the mapping between width [Range]s and layout builders.
  ///
  /// Each [Range] must be unique and non-overlapping.
  @protected
  Map<Range, LayoutChildBuilder> get ranges;

  /// Internal cache of the sorted and validated range entries.
  late final Iterable<MapEntry<Range, LayoutChildBuilder>> _rangeEntries;

  /// Builds the appropriate layout widget based on the current [breakpoint].
  ///
  /// Finds the first matching [Range] in [_rangeEntries] that includes the current
  /// breakpoint. If no match is found, it defaults to the first entry.
  @override
  @protected
  Widget layoutChildBuilder(
    BuildContext context, {
    required Widget? child,
    required Breakpoint breakpoint,
    required LayoutScope scope,
  }) {
    final builder = _rangeEntries.firstWhere(
      (entry) => breakpoint.isInRange(entry.key),
      orElse: () {
        final width = breakpoint.width;
        // If none is found, return the entry with the closest range.
        return _rangeEntries.reduce((a, b) {
          final aDistance = _rangeDistanceToWidth(a.key, width);
          final bDistance = _rangeDistanceToWidth(b.key, width);
          return aDistance < bDistance ? a : b;
        });
      },
    ).value;

    return builder(
      context,
      child,
      scope,
    );
  }

  /// Calculates how far the given width is from the provided [Range].
  ///
  /// If the width is within the range, this returns 0.
  /// If outside, it returns the distance to the nearest bound.
  double _rangeDistanceToWidth(Range range, double width) {
    if (width < range.minWidth) {
      return range.minWidth - width;
    } else if (width > range.maxWidth) {
      return width - range.maxWidth;
    }
    return 0;
  }
}

abstract base class Layout extends LayoutBase {
  const Layout({
    super.child,
    super.key,
  });

  LayoutChildBuilder? get small;
  LayoutChildBuilder get medium;
  LayoutChildBuilder? get large;

  @override
  bool get apply;

  @override
  Widget layoutChildBuilder(
    BuildContext context, {
    required Widget? child,
    required Breakpoint breakpoint,
    required LayoutScope scope,
  }) {
    return breakpoint.resolve(
      onL: IO.of((large ?? medium)(context, child, scope)),
      onM: IO.of(medium(context, child, scope)),
      onS: IO.of((small ?? medium)(context, child, scope)),
    );
  }
}
