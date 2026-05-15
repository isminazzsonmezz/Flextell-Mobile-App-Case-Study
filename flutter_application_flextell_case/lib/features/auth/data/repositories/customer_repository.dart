import 'package:flutter_application_flextell_case/core/network/dio_client.dart';
import 'package:flutter_application_flextell_case/features/auth/data/models/customer_model.dart';
import 'package:flutter_application_flextell_case/features/auth/data/services/customer_service.dart';

class CustomerRepository {

  final CustomerService service = CustomerService(
    DioClient.dioIntance,
  );

  Future<List<Customer>> getCustomers() async {
    return await service.getCustomers();
  }
}