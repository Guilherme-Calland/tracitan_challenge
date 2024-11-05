import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracitan_challenge_development/core/constants/messages.dart';
import 'package:tracitan_challenge_development/core/global_context.dart';
import 'package:tracitan_challenge_development/presentation/providers/asset_provider.dart';

class AssetPage extends StatelessWidget {
  AssetPage({super.key, required this.companyId}){
    final provider = globalContext!.read<AssetProvider>();
    provider.clear();
  }

  final String companyId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(),
          Expanded(child: Consumer<AssetProvider>(builder: (_, provider, __){
            if(provider.loading || provider.error){
              return Center(
                child: (){
                  if(provider.loading){
                    return const CircularProgressIndicator();
                  }else{
                    return const Text(Messages.error);
                  }
                }(),
              );
            }else{
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ...provider.locations.where((l) {
                      return l.parentId == null;
                    }).map((location) {
                      return Text(location.name);
                    }),
                    ...provider.assets.where((l) {
                      return l.parentId != null;
                    }).map((location) {
                      return Text(location.name);
                    }),
                  ],
                )
              );
            } 
          }))
        ],
      ),
    );
  }
}