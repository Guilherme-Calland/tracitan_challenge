import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracitan_challenge_development/core/constants/messages.dart';
import 'package:tracitan_challenge_development/presentation/providers/asset_provider.dart';

class AssetPage extends StatelessWidget {
  AssetPage(BuildContext context, {super.key}) {
    final provider = context.read<AssetProvider>();
    provider.clear();

    try{
      String companyId = ModalRoute.of(context)!.settings.arguments as String;
      WidgetsBinding.instance.addPostFrameCallback((_){
        provider.loadData(companyId);
      });
    }catch(e){
      debugPrint('$e');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Assets"),),
      body: Column(
        children: [
          Container(),
          Expanded(
            child: Consumer<AssetProvider>(
              builder: (_, provider, __) {
                if (provider.loading || provider.error) {
                  return Center(
                    child: () {
                      if (provider.loading) {
                        return const CircularProgressIndicator();
                      } else {
                        return const Text(Messages.error);
                      }
                    }(),
                  );
                } else {
                  return SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...provider.locations.where(
                            (location) {
                              return location.parentId == null;
                            },
                          ).map(
                            (locationNoParent) {
                              return Text(locationNoParent.name);
                            },
                          ),
                          ...provider.assets.where(
                            (asset) {
                              return asset.parentId == null;
                            },
                          ).map(
                            (assetNoParent) {
                              return Text(assetNoParent.name);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
