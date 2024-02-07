// esto puede ser una clase en la que se definan los saltos de pantalla

import 'package:collection/collection.dart';

enum Breakpoint {
  s(width: 360),
  m(width: 450),
  l(width: 1024),
  ;

  const Breakpoint({
    required this.width,
  });
  final int width;

  T resolve<T>({
    required T onL,
    required T onS,
    required T onM,
  }) {
    switch (this) {
      case Breakpoint.l:
        return onL;
      case Breakpoint.s:
        return onS;
      case Breakpoint.m:
        return onL;
    }
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
