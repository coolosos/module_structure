import 'package:flutter/widgets.dart';

///Contains the instances of all the component localizations.
///Usually a module contains one or more components that contains localizations
///and the module merge all of then in this class for being instance in the host.
abstract interface class ModuleLocalizations {
  const ModuleLocalizations();

  ///Contains all [LocalizationsDelegate] that are going a be placed in [WidgetsApp] and configured with the app's localizationsDelegates parameter.
  List<LocalizationsDelegate> get localizationDelegates;
}
