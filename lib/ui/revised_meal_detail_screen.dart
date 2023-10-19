//
//  revised_meal_detail_screen
//  posfe_keele
//
//  Created by Derek Rodriguez on October 16, 2023
//

import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/ui/menu_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class RevisedMealDetailScreen extends StatelessWidget {
  static const routName = '/mealDetail';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MenuViewModel>.nonReactive(
        viewModelBuilder: () => MenuViewModel(),
        builder: (context, viewModel, _) => _RevisedMealDetailScreen()
    );
  }
}

class _RevisedMealDetailScreen extends StackedHookView<MenuViewModel> {
  const _RevisedMealDetailScreen({super.key});

  @override
  Widget builder(BuildContext context, MenuViewModel model) {
    final mealID = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = model.mealForID(Id: mealID);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                itemBuilder: ((context, index) {
                  return Card(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Text(selectedMeal.ingredients[index])),
                  );
                }),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSectionTitle(context, "Steps"),
            buildContainer(
              ListView.builder(
                itemBuilder: ((context, index) {
                  return Column(children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.background,
                        child: Text(
                          '# ${index + 1}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      title: Text(selectedMeal.steps[index]),
                    ),
                    const Divider(),
                  ]);
                }),
                itemCount: selectedMeal.steps.length,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model.toggleFavorite(mealId: mealID),
        child: Icon(model.isMealFavorite(id: mealID) ? Icons.star : Icons.star_border),
      ),
    );
  }

  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

}
