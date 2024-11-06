import 'package:flutter/material.dart';
import 'package:tracitan_challenge_development/domain/entities/asset.dart';
import 'package:tracitan_challenge_development/domain/entities/company_item.dart';
import 'package:tracitan_challenge_development/domain/entities/location.dart';
import 'package:tracitan_challenge_development/presentation/pages/asset/widgets/company_expandable_item.dart';

class AssetList extends StatelessWidget {
  const AssetList({
    super.key,
    required this.items
  });

  final List<CompanyItem> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items.where(
            (item) {
              if (item is Location) {
                return item.parentId == null;
              } else {
                final asset = item as Asset;
                return asset.parentId == null && asset.locationId == null;
              }
            },
          ).map(
            (itemNoParent) {
              return CompanyExpandableItem(
                  currentItem: itemNoParent, allItems: items);
            },
          ).toList(),
        ),
      ),
    );
  }
}
