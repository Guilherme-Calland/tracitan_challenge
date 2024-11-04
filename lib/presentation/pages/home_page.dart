import 'package:flutter/material.dart';
import 'package:tracitan_challenge_development/core/global_context.dart';
import 'package:tracitan_challenge_development/presentation/controllers/home_controller.dart';
import 'package:tracitan_challenge_development/presentation/pages/widgets/company_button.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key}){
    final controller = globalContext!.read<HomeController>();
    controller.getCompanies();
  }

  @override
  Widget build(BuildContext _) {
    return Scaffold(
      body: Consumer<HomeController>(
        builder: (_, controller, __) {
          if(controller.loading){
            return const Center(
              child: CircularProgressIndicator(),
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

