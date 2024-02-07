import 'module_assets.dart';
import 'module_beans.dart';
import 'module_localizations.dart';

abstract interface class Module<L extends ModuleLocalizations,
    A extends ModuleAssets, B extends ModuleBeans> {
  const Module({
    required this.beans,
    required this.localizations,
    required this.assets,
  });

  final B beans;
  final L localizations;
  final A assets;
}
