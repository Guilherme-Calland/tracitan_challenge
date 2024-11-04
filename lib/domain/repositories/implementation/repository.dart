import 'package:dartz/dartz.dart';
import 'package:tracitan_challenge_development/data/adapters/asset_adapter.dart';
import 'package:tracitan_challenge_development/data/adapters/company_adapter.dart';
import 'package:tracitan_challenge_development/data/adapters/location_adapter.dart';
import 'package:tracitan_challenge_development/data/datasources/i_datasource.dart';
import 'package:tracitan_challenge_development/data/datasources/implementations/datasource.dart';
import 'package:tracitan_challenge_development/domain/entities/asset.dart';
import 'package:tracitan_challenge_development/domain/entities/company.dart';
import 'package:tracitan_challenge_development/domain/entities/location.dart';
import 'package:tracitan_challenge_development/domain/repositories/i_repository.dart';

class Repository implements IRepository{

  final IDatasource _datasource;
  final _companyAdapter  = CompanyAdapter();
  final _assetAdapter = AssetAdapter();
  final _locationAdapter = LocationAdapter();

  Repository(this._datasource);

  static Repository? _instance;
  static Repository getInstance(Datasource datasource){
    _instance ??= Repository(datasource);
    return _instance!;
  }

  @override
  Future<Either<Exception, List<Company>>> getCompanies() async{
    try{
      final result = await _datasource.getCompanies();
      return Right( result.map((json) => _companyAdapter.fromJson(json)).toList() );
    }catch(e){
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<Asset>>> getAssets(String companyId) async{
    try{
      final result = await _datasource.getAssets(companyId);
      return Right( result.map((json) => _assetAdapter.fromJson(json)).toList() );
    }catch(e){
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<Location>>> getLocations(String companyId) async {
     try{
      final result = await _datasource.getLocations(companyId);
      return Right( result.map((json) => _locationAdapter.fromJson(json)).toList());
    }catch(e){
      return Left(Exception(e));
    }
  }

}