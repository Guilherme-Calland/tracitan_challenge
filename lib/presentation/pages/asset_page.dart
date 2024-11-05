import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracitan_challenge_development/core/constants/messages.dart';
import 'package:tracitan_challenge_development/domain/entities/company_item.dart';
import 'package:tracitan_challenge_development/presentation/providers/asset_provider.dart';

class AssetPage extends StatelessWidget {
  AssetPage(BuildContext context, {super.key}) {
    final provider = context.read<AssetProvider>();
    provider.clear();

    try {
      String companyId = ModalRoute.of(context)!.settings.arguments as String;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        provider.loadData(companyId);
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
                        children: provider.items.where(
                            (item) {
                              return item.parentId == null;
                            },
                          ).map(
                            (itemNoParent) {
                              //RFT-1510 nao esquece de remover esse runtimeType
                              return TestWidget('${itemNoParent.name} ${itemNoParent.runtimeType}', children: provider.items.where((l) => l.parentId == itemNoParent.id).toList());
                            },
                          ).toList(),
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

class TestWidget extends StatefulWidget {
  const TestWidget(
    this.name, {
    super.key,
    required this.children
  });

  final String name;
  final List<CompanyItem> children;

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {

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
          child: Text(widget.name)
        ),
        if(visible)
         Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.children.map((parent){
              return TestWidget(parent.name, children: widget.children.where((child){
                return child.parentId == parent.id;
              }).toList());
            }).toList(),
          ),
        )
      ],
    );
  }
}
