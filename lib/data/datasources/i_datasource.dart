import 'package:dartz/dartz.dart';

abstract class IDatasource{
  Future<List<Map<String, dynamic>>> getCompanies();
  Future<List<dynamic>> getLocations(String companyId);
  Future<List<dynamic>> getAssets(String companyId);
}