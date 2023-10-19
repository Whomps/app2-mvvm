// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_shared/stacked_shared.dart';

import '../services/menu_manager_api.dart';
import '../services/menu_manager_local.dart';
import '../services/menu_manager_protocol.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton<MenuManagerProtocol>(() => MenuManagerLocal(),
      registerFor: {"local"});
  locator.registerLazySingleton<MenuManagerProtocol>(() => MenuManagerAPI(),
      registerFor: {"live"});
}
