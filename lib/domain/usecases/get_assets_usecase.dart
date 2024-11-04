import 'package:dartz/dartz.dart';
import 'package:tracitan_challenge_development/core/usecase.dart';
import 'package:tracitan_challenge_development/domain/entities/asset.dart';
import 'package:tracitan_challenge_development/domain/repositories/i_repository.dart';

class GetAssetsUsecase implements Usecase<Asset, String>{
  final IRepository _repository;

  GetAssetsUsecase(this._repository);

  @override
  Future<Either<Exception, List<Asset>>> call(String params) async{
    return await _repository.getAssets(params);
  }
}