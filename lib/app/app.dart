//
//  app.dart
//  posfe_keele
//
//  Created by Derek Rodriguez on October 16, 2023
//

import 'package:meal_app/services/menu_manager_protocol.dart';
import 'package:meal_app/services/menu_manager_api.dart';
import 'package:meal_app/services/menu_manager_local.dart';

import 'package:stacked/stacked_annotations.dart';


@StackedApp(
    routes: [], // TODO: Add Routes
    dependencies: [
      //  -> Be sure to re-run the generator after changing this file <-

      LazySingleton(classType: MenuManagerLocal, asType: MenuManagerProtocol, environments: { "local" }),
      LazySingleton(classType: MenuManagerAPI, asType: MenuManagerProtocol, environments: { "live" }),

    ]
)
class App {
  /** This class has no purpose besides housing the annotation that generates the required functionality **/
}