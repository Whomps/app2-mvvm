//
//  menu_manager_api
//  posfe_keele
//
//  Created by Derek Rodriguez on October 16, 2023
//
//  See the readme.txt in this directory for an explanation.
//  ListenableServiceMixin comes from Stacked.
//  It is not strictly necessary to use protocols or dependency injection.
//

import 'package:collection/collection.dart';
import 'package:meal_app/services/menu_manager_protocol.dart';
import 'package:meal_app/models/meal.dart';
import 'package:stacked/stacked.dart';


class MenuManagerAPI with ListenableServiceMixin implements MenuManagerProtocol {

  /* Public Properties */

  @override Map<String, bool> get filters => _filters.value;
  @override List<Meal> get allMeals => _allMeals;
  @override List<Meal> get availableMeals => _getAvailableMeals();
  @override List<Meal> get favoriteMeals => _favoriteMeals;


  /* Private Properties */

  final _filters = ReactiveValue<Map<String, bool>>({});
  final _allMeals = ReactiveList<Meal>();
  final _favoriteMeals = ReactiveList<Meal>();


  /* Lifecycle */

  ManagerMenuAPI() { _setup(); }

  void _setup() {
    // When these values update, all subscribers to this data source will also update.
    // This means that if filters update, then a screen only concerned with favorites will also update.
    // That is one drawback of this technique, but is also a drawback that widely exists with Flutter and ChangeNotifiers.
    listenToReactiveValues([
      _filters,
      _allMeals,
      _favoriteMeals
    ]);

    _getMenuFromAPI();
  }


  /* Interface Methods */

  void setFilters({required Map<String, bool> filterData}) {
    _filters.value = filterData;
  }

  void toggleFavorites({required String mealId}) {
    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    // I try to keep the cognitive complexity down. Compare this to lines 62-76 of main.dart
    // Not everyone will approve of smashing lines together like this.
    if (existingIndex > 0) { _favoriteMeals.removeAt(existingIndex); return; }

    // This is the implicit 'else':
    final fav = _allMeals.firstWhereOrNull((meal) => meal.id == mealId);
    if (fav == null) { return; }

    _favoriteMeals.add(fav);
  }


  /* Private Methods */

  List<Meal> _getAvailableMeals() {
    return _allMeals.where((meal) {
      if (_filters.value['gluten']! && !meal.isGlutenFree) {
        return false;
      }
      if (_filters.value['lactose']! && !meal.isLactoseFree) {
        return false;
      }
      if (_filters.value['vegan']! && !meal.isVegan) {
        return false;
      }
      if (_filters.value['vegetarian']! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
  }

  // This is the difference between Local and API.
  // Here, we expect the list of meals may be updated from the network.
  void _getMenuFromAPI() {
    // TODO: Get the menu from an API
    // Then put it in _allMeals
  }

}