import 'package:collection/collection.dart';
import 'package:fpdart/fpdart.dart';
export 'package:fpdart/fpdart.dart' show IO;

enum Breakpoint {
  s(width: 320),
  m(width: 600),
  l(width: 1024),
  ;

  const Breakpoint({
    required this.width,
  });

  factory Breakpoint.breakpointOf(double maxWidth) {
    return Breakpoint.sortedValues.firstWhere(
      (breakpoint) => maxWidth >= breakpoint.width,
      orElse: () => Breakpoint.s,
    );
  }

  final double width;

  T resolve<T>({
    required IO<T> onL,
    required IO<T> onM,
    required IO<T> onS,
  }) {
    final io = switch (this) {
      Breakpoint.l => onL,
      Breakpoint.m => onM,
      Breakpoint.s => onS,
    };
    return io.run();
  }

  static List<Breakpoint> get sortedValues {
    return Breakpoint.values.sorted((a, b) => b.width.compareTo(a.width));
  }

  Breakpoint? get smaller {
    return {
      Breakpoint.s: null,
      Breakpoint.m: Breakpoint.s,
      Breakpoint.l: Breakpoint.m,
    }[this];
  }

  Breakpoint? get bigger {
    return {
      Breakpoint.s: Breakpoint.m,
      Breakpoint.m: Breakpoint.l,
      Breakpoint.l: null,
    }[this];
  }

  bool get isS => Breakpoint.s == this;

  bool get isM => Breakpoint.m == this;

  bool get isL => Breakpoint.l == this;

  bool operator <(Breakpoint breakpoint) => index < breakpoint.index;
  bool operator >(Breakpoint breakpoint) => index > breakpoint.index;
  bool operator <=(Breakpoint breakpoint) => index <= breakpoint.index;
  bool operator >=(Breakpoint breakpoint) => index >= breakpoint.index;
}
