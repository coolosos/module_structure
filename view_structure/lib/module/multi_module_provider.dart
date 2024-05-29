import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

import 'module_provider.dart';

typedef ModuleBuilder = Widget Function(
  BuildContext context,
);

base class MultiModuleProvider extends Nested {
  MultiModuleProvider({
    required List<ModuleProvider> modules,
    required ModuleBuilder builder,
    super.key,
  }) : super(
          child: Builder(
            builder: (context) => builder(
              context,
            ),
          ),
          children: modules,
        );
}
