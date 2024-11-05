import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracitan_challenge_development/core/routes.dart';
import 'package:tracitan_challenge_development/core/providers/provider_aux.dart';
import 'package:tracitan_challenge_development/presentation/pages/asset_page.dart';
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
      routes:{
        AppRoutes.home: (context) => HomePage(context),
        AppRoutes.assets: (context)=> AssetPage(context)
      },
    );
  }
}