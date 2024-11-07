import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracitan_challenge_development/core/constants/enums/component_status.dart';
import 'package:tracitan_challenge_development/core/constants/messages.dart';
import 'package:tracitan_challenge_development/domain/entities/asset.dart';
import 'package:tracitan_challenge_development/domain/entities/location.dart';
import 'package:tracitan_challenge_development/presentation/pages/asset/widgets/company_expandable_item.dart';
import 'package:tracitan_challenge_development/presentation/pages/asset/widgets/status_button.dart';
import 'package:tracitan_challenge_development/presentation/providers/asset_provider.dart';

class AssetPage extends StatelessWidget {
  AssetPage(BuildContext context, {super.key}) {
    final assetProvider = context.read<AssetProvider>();
    assetProvider.clear();

    try {
      String companyId = ModalRoute.of(context)!.settings.arguments as String;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        assetProvider.loadData(companyId);
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Assets"),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (val){
              final assetProvider = context.read<AssetProvider>();
              assetProvider.searchItem(val);
            },
          ),
          Expanded(
            child: Consumer<AssetProvider>(
              builder: (_, provider, __) {
                return Column(
                  children: [
                    Row(
                      children: ComponentStatus.values.map((s) {
                        return StatusButton(
                          selected: provider.status == s,
                          onSelected: () => provider.changeStatus(s),
                          label: s.label,
                        );
                      }).toList(),
                    ),
                    Expanded(child: () {
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
                              children: provider.items.where(
                                (item) {
                                  if (item is Location) {
                                    return item.parentId == null;
                                  } else {
                                    final asset = item as Asset;
                                    return asset.parentId == null &&
                                        asset.locationId == null;
                                  }
                                },
                              ).map(
                                (itemNoParent) {
                                  return CompanyExpandableItem(
                                      currentItem: itemNoParent,
                                      allItems: provider.items);
                                },
                              ).toList(),
                            ),
                          ),
                        );
                      }
                    }())
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
