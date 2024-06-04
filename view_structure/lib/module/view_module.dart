import 'package:flutter/widgets.dart';

import 'module_assets.dart';
import 'module_localizations.dart';

@immutable
sealed class ViewModule<L, A, B> {
  const ViewModule({
    required this.localizations,
    required this.assets,
    required this.beans,
  });
  final L localizations;
  final A assets;
  final B beans;
}

@immutable
abstract base class WidgetsModule<L extends ModuleLocalizations,
    A extends ModuleAssets, B extends Object> extends ViewModule<L, A, B> {
  const WidgetsModule({
    required super.localizations,
    required super.assets,
    required super.beans,
  });

  List<LocalizationsDelegate> get localizationDelegates =>
      localizations.localizationDelegates;
}
