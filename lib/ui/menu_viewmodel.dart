//
//  menu_viewmodel
//  posfe_keele
//
//  Created by Derek Rodriguez on October 16, 2023
//

import 'package:collection/collection.dart';
import 'package:meal_app/app/app.locator.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/services/menu_manager_protocol.dart';

import 'package:stacked/stacked.dart';


class MenuViewModel extends ReactiveViewModel {

  /* Public Properties */
  Map<String, bool> get filters => _mmp.filters;
  List<Meal> get allMeals => _mmp.allMeals;
  List<Meal> get availableMeals => _mmp.availableMeals;
  List<Meal> get favoriteMeals => _mmp.favoriteMeals;


  /* Private Properties */
  MenuManagerProtocol get _mmp => locator<MenuManagerProtocol>();

  /* Mixin */

  @override List<ListenableServiceMixin> get listenableServices => [_mmp];


  /* Lifecycle */

  MenuViewModel() { }

  /* Helpers */

  bool isMealFavorite({required String id}) {
    return favoriteMeals.any((meal) => meal.id == id);
  }

  List<Meal> mealsForCategory({required String catId}) {
    return availableMeals.where((meal) => meal.categories.contains(catId)).toList();
  }

  /// This is used to safely get a meal. It will make up a placeholder if no meal is found.
  Meal mealForID({required String Id}) {
    return allMeals.firstWhereOrNull((meal) => meal.id == Id) ?? Meal.ph();
  }

  void toggleFavorite({required String mealId}) {
    _mmp.toggleFavorites(mealId: mealId);
  }

  // I did not add required here for compatibility with FilterScreen parameters
  void setFilters(Map<String, bool> filterData) {
    _mmp.setFilters(filterData: filterData);
  }

}