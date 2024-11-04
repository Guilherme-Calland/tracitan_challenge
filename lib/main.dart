import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracitan_challenge_development/core/app_navigator.dart';
import 'package:tracitan_challenge_development/core/providers/provider_aux.dart';
import 'package:tracitan_challenge_development/presentation/pages/home_page.dart';
void main() {
  runApp(MultiProvider(
    providers: ProviderAux.providers,
    child: const TracitanChallenge(),
  ));
}

class TracitanChallenge extends StatelessWidget {
  const TracitanChallenge({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: AppNavigator.navigatorKey,
      home: HomePage(),
    );
  }
}