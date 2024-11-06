
import 'package:flutter/material.dart';
import 'package:tracitan_challenge_development/core/constants/image_paths.dart';
import 'package:tracitan_challenge_development/domain/entities/asset.dart';
import 'package:tracitan_challenge_development/domain/entities/company_item.dart';
import 'package:tracitan_challenge_development/domain/entities/location.dart';

class CompanyExpandableItem extends StatefulWidget {
  const CompanyExpandableItem(
    {
    required this.currentItem, required this.allItems,
    super.key,
  });

  final CompanyItem currentItem;
  final List<CompanyItem> allItems;

  @override
  State<CompanyExpandableItem> createState() => _CompanyExpandableItemState();
}

class _CompanyExpandableItemState extends State<CompanyExpandableItem> {

  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: (){
            setState(() {
              visible = !visible;
            });
          },
          child: Row(
            children: [
              Image.asset((){
                if(widget.currentItem is Asset){
                  final asset = widget.currentItem as Asset;

                  bool hasSensorType = asset.sensorType != null;
                  if(hasSensorType){
                    return ImagePaths.componentIcon;
                  }else{
                    return ImagePaths.assetIcon;
                  }
                }
                return ImagePaths.locationIcon;
              }(), height: 22.0, width: 22.0,),
              Expanded(child: Text(widget.currentItem.name)),
            ],
          )
        ),
        if(visible)
         Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.allItems
            .where((child){
              if(child is Location){
                return child.parentId == widget.currentItem.id;
              }else{
                final asset = child as Asset;
                final currentItemId = widget.currentItem.id;
                return asset.parentId == currentItemId || asset.locationId == currentItemId;
              }
            })
            .map((child){
              return CompanyExpandableItem(currentItem: child, allItems: widget.allItems);
            }).toList(),
          ),
        )
      ],
    );
  }
}
