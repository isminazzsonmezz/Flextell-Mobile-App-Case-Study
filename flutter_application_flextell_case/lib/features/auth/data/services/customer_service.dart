import 'package:dio/dio.dart';
import 'package:flutter_application_flextell_case/core/constants/api_constants.dart';
import 'package:flutter_application_flextell_case/features/auth/data/models/customer_model.dart';

class CustomerService {
  final Dio dio;

  CustomerService(this.dio);

  Future<List<Customer>> getCustomers() async {
    final response = await dio.get(ApiConstants.customers);

    return (response.data as List).map((e) => Customer.fromJson(e)).toList();
  }
}
