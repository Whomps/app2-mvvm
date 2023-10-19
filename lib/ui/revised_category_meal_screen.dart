//
//  revised_category_meal_screen
//  posfe_keele
//
//  Created by Derek Rodriguez on October 16, 2023
//

import 'package:flutter/material.dart';
import 'package:meal_app/ui/menu_viewmodel.dart';
import 'package:meal_app/widgets/meal_item.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class RevisedCategoryMealScreen extends StatelessWidget {
  static const routName = 'displayedMeals';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MenuViewModel>.nonReactive(
      viewModelBuilder: () => MenuViewModel(),
      builder: (context, viewModel, _) => _RevisedCategoryMealScreen()
    );
  }

}

// This widget will update any time the listenableServices of the ViewModel updates.
// So whenever _mmp updates, this updates.
class _RevisedCategoryMealScreen extends StackedHookView<MenuViewModel> {

  @override
  Widget builder(BuildContext context, MenuViewModel model) {

    // This is a little messy - I would avoid it if possible in a simple app.
    // But since it's here already, I will include it - slightly modified because it is causing an error.
    Map<String, String>? routeArgs;
    if (ModalRoute.of(context)!.settings.arguments is Map<String, String>) {
      routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    }
    final categoryTitle = routeArgs?['title'] ?? "Missing Title";
    final categoryId = routeArgs?['id'] ?? "0";
    // TODO: So the above does seem to cause issues unless the route is followed as expected.
    // TODO: Needs debug because Line 36 comes back as a string instead of as Map

    final displayedMeals = model.mealsForCategory(catId: categoryId);

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            affordability: displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity,
            duration: displayedMeals[index].duration,
          );
        }),
        itemCount: displayedMeals.length,
      ),
    );
  }



}