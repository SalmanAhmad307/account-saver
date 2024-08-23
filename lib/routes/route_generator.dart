// route_generator.dart
import 'package:account_saver/ui/favorite_screen/favorite_screen.dart';
import 'package:account_saver/ui/navi%20bar/home/home_screen.dart';
import 'package:account_saver/ui/search_screen.dart/search_screen.dart';
import 'package:flutter/material.dart';
import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case Routes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case Routes.favorites:
        return MaterialPageRoute(builder: (_) => const FavoriteScreen());
      case Routes.search: // Add the search route here
        return MaterialPageRoute(builder: (_) => const SearchScreen());

      // Add more cases for additional routes
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Page not found'),
        ),
      );
    });
  }
}