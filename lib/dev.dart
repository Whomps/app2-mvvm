//
//  dev.dart
//  posfe_keele
//
//  Created by Derek Rodriguez on October 16, 2023
//
//  This is an additional entry point to help demonstrate some techniques to
//  improve the scalability to aesthetic of the code.
//
//  Entry point configuration is stores in the .idea directory and requires
//  either Android Studio or IntelliJ to use. Visual Studio has its own system.
//

import 'package:flutter/material.dart';
import 'package:meal_app/app/app.locator.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';
import 'package:meal_app/ui/menu_viewmodel.dart';
import 'package:meal_app/ui/revised_category_meal_screen.dart';
import 'package:meal_app/ui/revised_meal_detail_screen.dart';
import './screens/tabs_screen.dart';

void main(List<String> args) {

  // This sets up the environment defined+generated in app.dart
  setupLocator(environment: 'local');

  runApp(const RevisedApp());
}

class RevisedApp extends StatelessWidget {
  const RevisedApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Raleway',
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 25,  //font size for "Categories"
                fontWeight: FontWeight.bold)),
        colorScheme: ColorScheme.fromSwatch(
          //changed colors
          primarySwatch: Colors.blueGrey, //color of app bar  background
          accentColor: Colors.white, //color of app bar text
        ),

        //Sara changed Categories background color

        canvasColor: Colors.white,
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyLarge: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          bodyMedium: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          bodySmall: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          titleLarge: const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 21, //font size for buttons title
            fontWeight: FontWeight.bold,
          ),
          titleMedium: const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: "IkiMeal",
      //home: CategoriesScreen(),
      initialRoute: '/', //default is '/'
      routes: {
        '/': (context) => TabsScreen(MenuViewModel().favoriteMeals),

        /// These screens have been fully converted to the simple Stacked / MVVM arch.
        /// The ViewModel dependency is pulled from within the Screen's tree.
        RevisedCategoryMealScreen.routName: (context) => RevisedCategoryMealScreen(),
        RevisedMealDetailScreen.routName: (context) => RevisedCategoryMealScreen(),

        /// This screens is retrofitted using out-of-pattern solutions
        /// This is a bit ugly because it makes a bunch of MenuViewModel instances, but it does show the strength in flexibility of this arch.
        /// Keep this in mind: each instance of the ViewModel is different, unless it is provided by the same provider.
        /// But the methods of each ViewModel link back up to the singleton MenuManager. So the VM isn't state, it is just an access point. (in this case)
        /// (NOTE) There are likely bugs :)
        FiltersScreen.routName: (context) => FiltersScreen(MenuViewModel().filters, MenuViewModel().setFilters),
      },
      onUnknownRoute: (settings) {
        MaterialPageRoute(
          builder: ((context) => TabsScreen(MenuViewModel().favoriteMeals)),
        );
        return null;
      },
    );
  }

}
