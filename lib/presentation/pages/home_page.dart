import 'package:flutter/material.dart';
import 'package:tracitan_challenge_development/core/global_context.dart';
import 'package:tracitan_challenge_development/core/widgets/company_button.dart';
import 'package:tracitan_challenge_development/presentation/providers/home_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key}){
    WidgetsBinding.instance.addPostFrameCallback((_){
      final controller = globalContext!.read<HomeProvider>();
      controller.getCompanies();
    });
  }

  @override
  Widget build(BuildContext _) {
    return Scaffold(
      body: Consumer<HomeProvider>(
        builder: (_, controller, __) {
          if(controller.loading || controller.hasError){
            return Center(
              child: (){
                if(controller.loading){
                  return const CircularProgressIndicator();
                }else{
                  return const Text("An error has occured");
                }
              }()
            );
          }else{
            return ListView.separated(
              separatorBuilder: (_, __){
                return const SizedBox(height: 40.0);
              },
              itemCount: controller.companies.length,
              itemBuilder: (_, index) {
                final company = controller.companies[index];
                return CompanyButton(company: company, onTap: (companyId){
                  
                },);
              },
            );
          }
        },
      ),
    );
  }
}

