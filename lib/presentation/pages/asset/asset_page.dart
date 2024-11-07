import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracitan_challenge_development/core/constants/app_colors.dart';
import 'package:tracitan_challenge_development/core/constants/enums/component_status.dart';
import 'package:tracitan_challenge_development/core/constants/messages.dart';
import 'package:tracitan_challenge_development/core/widgets/loading_indicator.dart';
import 'package:tracitan_challenge_development/core/widgets/seach_bar.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        centerTitle: true,
        leading: _buildAppBarLeadingWidget(context),
        title: Text(
          "Assets",
          style: _buildAppBarTitleTextStyle(),
        ),
      ),
      body: Column(
        children: [
          AppSearchBar(
            hint: "Buscar Ativo ou Local",
            onQueryChanged: (query) => _searchItem(context: context, query: query),
            controller: (){
              final provider = context.read<AssetProvider>();
              return provider.searchController;
            }(),
          ),
          Expanded(
            child: Consumer<AssetProvider>(
              builder: (_, provider, __) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        children: List.generate(
                          ComponentStatus.values.length,
                          (index) {
                            final status = ComponentStatus.values[index];
                            final isFirst = index == 0;
                            return Padding(
                              padding: isFirst ? EdgeInsets.zero : const EdgeInsets.only(left: 8.0),
                              child: StatusButton(
                                iconPath: status.iconPath,
                                selected: provider.status == status,
                                onSelected: (){
                                  _hideKeyBoard(context);
                                  provider.changeStatus(status);
                                },
                                label: status.label,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),                            
                    Expanded(child: () {
                      if (provider.loading || provider.error || provider.emptyList) {
                        return Center(
                          child: () {
                            if (provider.loading) {
                              return const LoadingIndicator();
                            } else if(provider.error) {
                              return const Text(Messages.error);
                            } else {
                              return const Text(Messages.noItemsFound);
                            }
                          }(),
                        );
                      } else {
                        return Container(
                          padding: const EdgeInsets.only(left: 16.0),
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

  void _hideKeyBoard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  TextStyle _buildAppBarTitleTextStyle() {
    return const TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
    );
  }

  GestureDetector _buildAppBarLeadingWidget(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Icon(
          Icons.keyboard_arrow_left,
          color: Colors.white,
          size: 32.0,
        ),
      );
  }

  _searchItem({
    required BuildContext context,
    required String query,
  }) {
    final assetProvider = context.read<AssetProvider>();
    assetProvider.searchItem(query);
  }
}
