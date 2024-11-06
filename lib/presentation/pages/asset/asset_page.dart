import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracitan_challenge_development/core/constants/enums/component_status.dart';
import 'package:tracitan_challenge_development/core/constants/messages.dart';
import 'package:tracitan_challenge_development/domain/entities/asset.dart';
import 'package:tracitan_challenge_development/domain/entities/location.dart';
import 'package:tracitan_challenge_development/presentation/pages/asset/widgets/asset_list.dart';
import 'package:tracitan_challenge_development/presentation/pages/asset/widgets/company_expandable_item.dart';
import 'package:tracitan_challenge_development/presentation/pages/asset/widgets/status_button.dart';
import 'package:tracitan_challenge_development/presentation/providers/asset_provider.dart';
import 'package:tracitan_challenge_development/presentation/providers/status_provider.dart';

class AssetPage extends StatelessWidget {
  AssetPage(BuildContext context, {super.key}) {
    final assetProvider = context.read<AssetProvider>();
    assetProvider.clear();
    final statusProvider = context.read<StatusProvider>();
    statusProvider.clear();

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
          Consumer<StatusProvider>(builder: (_, provider, __) {
            return Row(
              children: ComponentStatus.values.map((s) {
                return StatusButton(
                  selected: provider.status == s,
                  onSelected: () => provider.changeStatus(s),
                  label: s.label,
                );
              }).toList(),
            );
          }),
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
                  return AssetList(
                    items: provider.items,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
