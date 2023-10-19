//
//  menu_manager_protocol
//  posfe_keele
//
//  Created by Derek Rodriguez on October 16, 2023
//
//  See the readme.txt in this directory for an explanation.
//  ListenableServiceMixin comes from Stacked.
//  It is not strictly necessary to use protocols or dependency injection.
//

import 'package:stacked/stacked.dart';
import 'package:meal_app/models/meal.dart';

abstract class MenuManagerProtocol with ListenableServiceMixin {

  // These were previously defined in main.dart.
  Map<String, bool> get filters;
  List<Meal> get allMeals;
  List<Meal> get availableMeals;
  List<Meal> get favoriteMeals;

  void setFilters({required Map<String, bool> filterData});

  void toggleFavorites({required String mealId});

  // isMealFavorite is not included here because it doesn't handle state.
  // I prefer to put it in the ViewModel. Keeps this layer from getting too busy + DRYs code.
  // Remember: the abstract implementation defined here must be concrete in at least 2 other locations.

}