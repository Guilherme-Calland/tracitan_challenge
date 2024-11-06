import 'package:flutter/material.dart';
import 'package:tracitan_challenge_development/core/constants/messages.dart';
import 'package:tracitan_challenge_development/presentation/pages/home/widgets/company_button.dart';
import 'package:tracitan_challenge_development/presentation/providers/home_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage(BuildContext context, {super.key}){
    WidgetsBinding.instance.addPostFrameCallback((_){
      final provider = context.read<HomeProvider>();
      provider.getCompanies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeProvider>(
        builder: (context, controller, __) {
          if(controller.loading || controller.hasError){
            return Center(
              child: (){
                if(controller.loading){
                  return const CircularProgressIndicator();
                }else{
                  return const Text(Messages.error);
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
                return CompanyButton(company: company);
              },
            );
          }
        },
      ),
    );
  }
}

