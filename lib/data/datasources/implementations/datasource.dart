import 'package:tracitan_challenge_development/core/network/api_client.dart';
import 'package:tracitan_challenge_development/data/datasources/i_datasource.dart';

class Datasource implements IDatasource{

  static const String _baseUrl = 'https://fake-api.tractian.com';
  final ApiClient _apiClient;

  static Datasource? _instance;
  static Datasource getInstance(ApiClient client){
    _instance ??= Datasource(client);
    return _instance!;
  }

  Datasource(this._apiClient);

  @override
  Future<List<dynamic>> getCompanies() async {
    try{
      const String url = '$_baseUrl/companies';
      final response = await _apiClient.get(url);
      final success = response.statusCode == 200 && response.data != null;
      if(success){
        return response.data!;
      }else{
        throw Exception("Status code: ${response.statusCode}");
      }
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List> getAssets(String companyId) async {
    // TODO: implement getLocations

    throw UnimplementedError();

  }


  @override
  Future<List> getLocations(String companyId) {
    // TODO: implement getLocations
    throw UnimplementedError();
  }
}