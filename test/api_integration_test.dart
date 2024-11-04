import 'package:flutter/material.dart';
import 'package:tracitan_challenge_development/core/network/api_client.dart';
import 'package:tracitan_challenge_development/core/usecase.dart';
import 'package:tracitan_challenge_development/data/datasources/implementations/datasource.dart';
import 'package:tracitan_challenge_development/domain/repositories/implementation/repository.dart';
import 'package:tracitan_challenge_development/domain/usecases/get_companies_usecase.dart';

void main() async{
  final apiClient = ApiClient();
  final datasource = Datasource.getInstance(apiClient);
  final repository = Repository.getInstance(datasource);
  final usecase = GetCompaniesUsecase(repository);

  final result = await usecase(const NoParams());
  debugPrint('$result');
}
