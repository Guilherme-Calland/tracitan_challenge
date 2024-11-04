import 'package:dartz/dartz.dart';
import 'package:tracitan_challenge_development/domain/entities/asset.dart';
import 'package:tracitan_challenge_development/domain/entities/company.dart';
import 'package:tracitan_challenge_development/domain/entities/location.dart';

abstract class IRepository{
  Future<Either<Exception, List<Company>>> getCompanies();
  Future<Either<Exception, List<Location>>> getLocations();
  Future<Either<Exception, List<Asset>>> getAssets();
}