import 'package:dartz/dartz.dart';

abstract class IDatasource{
  Future<Either<Exception, List<Map<String, dynamic>>>> getCompanies();
  Future<Either<Exception, List<dynamic>>> getLocations(String companyId);
  Future<Either<Exception, List<dynamic>>> getAssets(String companyId);
}