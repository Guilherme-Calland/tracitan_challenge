import 'package:tracitan_challenge_development/domain/entities/company.dart';

class CompanyAdapter{
  Company fromJson(Map<String, dynamic> json){
    return Company(id: json['id'], name: json['name']);
  }
}