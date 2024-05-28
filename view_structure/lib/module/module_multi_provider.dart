import 'package:nested/nested.dart';

import 'module_provider.dart';

base class MultiModuleProvider extends Nested {
  MultiModuleProvider({
    required List<ModuleProvider> components,
    super.key,
  }) : super(
          children: components,
        );
}
