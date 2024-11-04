import 'package:flutter/material.dart';
import 'package:tracitan_challenge_development/core/usecase.dart';
import 'package:tracitan_challenge_development/domain/entities/company.dart';
import 'package:tracitan_challenge_development/domain/usecases/get_companies_usecase.dart';

class HomeController extends ChangeNotifier{
  final GetCompaniesUsecase getCompaniesUsecase;

  HomeController({
    required this.getCompaniesUsecase,
  });

  bool _loading = true;
  bool get loading => _loading;

  bool _error = false;
  bool get errror => _error;

  final List<Company> _companies = [];
  List<Company> get companies => _companies;

  Future<void> getCompanies()async{
    _error = false;
    _loading = true;
    notifyListeners();

    final result = await getCompaniesUsecase(const NoParams());
    result.fold((_){
      _error = true;
    }, (companiesResult){
      _companies.clear();
      _companies.addAll(companiesResult);
    });

    _loading = false;
    notifyListeners();
  }
}