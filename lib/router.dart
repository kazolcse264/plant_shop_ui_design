/*


import 'package:flutter/material.dart';
import 'package:plant_shop_ui_design/pages/home.dart';
import 'package:plant_shop_ui_design/pages/intro.dart';

class AppRouter{
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Intro.routeName:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Intro(),
        );
      case Home.routeName:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Home(),

        );
      default:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Screen does not exist!'),
            ),
          ),
        );
    }
  }
}

*/
import 'package:flutter/material.dart';
import 'package:plant_shop_ui_design/pages/home.dart';
import 'package:plant_shop_ui_design/pages/intro.dart';
import 'package:plant_shop_ui_design/pages/plant_detail.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Intro.routeName:
        return PageRouteBuilder(
          settings: routeSettings,
          pageBuilder: (_, __, ___) => const Intro(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 1000),
        );
      case Home.routeName:
        return PageRouteBuilder(
          settings: routeSettings,
          pageBuilder: (_, __, ___) => const Home(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 1000),
        );

      case PlantDetail.routeName:
        var id = routeSettings.arguments as int;
        return PageRouteBuilder(
          settings: routeSettings,
          pageBuilder: (_, __, ___) =>  PlantDetail(id: id,),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 1000),
        );

      default:
        return PageRouteBuilder(
          settings: routeSettings,
          pageBuilder: (_, __, ___) => const Scaffold(
            body: Center(
              child: Text('Screen does not exist!'),
            ),
          ),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 1000),
        );
    }
  }
}
