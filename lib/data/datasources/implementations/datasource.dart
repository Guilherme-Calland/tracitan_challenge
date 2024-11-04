import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tracitan_challenge_development/core/network/api_client.dart';
import 'package:tracitan_challenge_development/data/datasources/i_datasource.dart';

class Datasource implements IDatasource{

  static const String _baseUrl = 'fake-api.tractian.com';
  final apiClient = ApiClient();

  @override
  Future<Either<Exception, List<Map<String, dynamic>>>> getCompanies() async {
    try{
      const String url = '$_baseUrl/companies';
      final response = await apiClient.get(url);
      final success = response.statusCode == 200 && response.data != null;
      if(success){
        return Right(response.data!);
      }else{
        throw Exception("Status code: ${response.statusCode}");
      }
    }catch(e){
      debugPrint("$e");
      throw Exception(e);
    }
  }

  @override
  Future<Either<Exception, List>> getAssets(String companyId) async {
    // TODO: implement getLocations

    throw UnimplementedError();

  }


  @override
  Future<Either<Exception, List>> getLocations(String companyId) {
    // TODO: implement getLocations
    throw UnimplementedError();
  }

}