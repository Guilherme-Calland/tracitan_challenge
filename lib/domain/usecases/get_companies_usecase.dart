import 'package:dartz/dartz.dart';
import 'package:tracitan_challenge_development/core/usecase.dart';
import 'package:tracitan_challenge_development/domain/entities/company.dart';
import 'package:tracitan_challenge_development/domain/repositories/i_repository.dart';

class GetCompaniesUsecase implements Usecase<Company, NoParams>{
  final IRepository _repository;

  GetCompaniesUsecase(this._repository);

  @override
  Future<Either<Exception, List<Company>>> call(NoParams params) {
    return _repository.getCompanies();
  }
}