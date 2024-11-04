// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
