import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:tracitan_challenge_development/core/network/api_client.dart';
import 'package:tracitan_challenge_development/data/datasources/implementations/datasource.dart';
import 'package:tracitan_challenge_development/domain/repositories/implementation/repository.dart';
import 'package:tracitan_challenge_development/domain/usecases/get_companies_usecase.dart';
import 'package:tracitan_challenge_development/presentation/controllers/home_controller.dart';

class ProviderAux {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<HomeController>(
      create: (_) {
        final apiClient = ApiClient.getInstance();
        final datasource = Datasource.getInstance(apiClient);
        final repository = Repository.getInstance(datasource);
        final usecase = GetCompaniesUsecase(repository);
        return HomeController(getCompaniesUsecase: usecase);
      },
    )
  ];
}
