import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  pop(String routeName) {
    _navigationKey.currentState?.popUntil((route) =>
    route.isCurrent && route.settings.name == routeName ? false : true);
  }

  navigateTo(String routeName, {dynamic arguments}) {
    bool isNewRouteSameAsCurrent = false;
    _navigationKey.currentState?.popUntil((route) {
      if (route.isCurrent && route.settings.name == routeName) {
        isNewRouteSameAsCurrent = true;
      }
      return true;
    });

    if (!isNewRouteSameAsCurrent) {
      _navigationKey.currentState?.pushNamed(routeName, arguments: arguments);
    }

    // return _navigationKey.currentState.pushNamedAndRemoveUntil(
    //     routeName,
    //     (route) =>
    //         route.isCurrent && route.settings.name == routeName ? false : true,
    //     arguments: arguments);
  }
  // Navigate to a route using the navigatorKey

}
