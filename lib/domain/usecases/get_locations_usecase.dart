import 'package:dartz/dartz.dart';
import 'package:tracitan_challenge_development/core/usecase.dart';
import 'package:tracitan_challenge_development/domain/entities/location.dart';
import 'package:tracitan_challenge_development/domain/repositories/i_repository.dart';

class GetLocationsUsecase implements Usecase<Location, String>{
  final IRepository _repository;

  GetLocationsUsecase(this._repository);

  @override
  Future<Either<Exception, List<Location>>> call(String params) async{
    return await _repository.getLocations(params);
  }
}