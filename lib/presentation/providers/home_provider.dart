import 'package:flutter/material.dart';
import 'package:tracitan_challenge_development/core/usecase.dart';
import 'package:tracitan_challenge_development/domain/entities/company.dart';
import 'package:tracitan_challenge_development/domain/usecases/get_companies_usecase.dart';

class HomeProvider extends ChangeNotifier{
  final GetCompaniesUsecase getCompaniesUsecase;

  HomeProvider({
    required this.getCompaniesUsecase,
  });

  bool _loading = true;
  bool get loading => _loading;

  bool _hasError = false;
  bool get hasError => _hasError;

  final List<Company> _companies = [];
  List<Company> get companies => _companies;

  Future<void> getCompanies()async{
    _hasError = false;
    _loading = true;
    notifyListeners();

    final result = await getCompaniesUsecase(const NoParams());
    result.fold((e){
      _hasError = true;
      debugPrint('$e');
    }, (companiesResult){
      _companies.clear();
      _companies.addAll(companiesResult);
    });

    _loading = false;
    notifyListeners();
  }
}