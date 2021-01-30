import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState> navigationKey;

  static NavigationService instance = NavigationService();

  NavigationService() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  Future<dynamic> navigateToReplacement(String _rn, {dynamic arguments}) {
    return navigationKey.currentState
        .pushReplacementNamed(_rn, arguments: arguments);
  }

  Future<dynamic> navigateTo(String _rn, {dynamic arguments}) {
    return navigationKey.currentState.pushNamed(_rn, arguments: arguments);
  }

  Future<dynamic> navigateToRoute(MaterialPageRoute _rn) {
    return navigationKey.currentState.push(_rn);
  }

  goback({dynamic results}) {
    return navigationKey.currentState.pop(results);
  }
}
