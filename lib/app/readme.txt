This is a very simplified dependency injection scheme from one of my apps.

There are two environments: live and local. You must define which of these you will use within the entry point.
In dev.dart, I target the local environment. I did not include anything to target the live environment in this example.

The command to run the code generator is:
  flutter pub run build_runner build --delete-conflicting-outputs
