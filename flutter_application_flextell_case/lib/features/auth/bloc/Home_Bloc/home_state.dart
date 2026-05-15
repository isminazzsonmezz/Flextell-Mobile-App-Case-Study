import 'package:flutter_application_flextell_case/features/auth/data/models/auth_token_model.dart';
import 'package:flutter_application_flextell_case/features/auth/data/models/customer_model.dart';

abstract class HomeState {}

class HomePageLoading extends HomeState {}

class HomePageLoaded extends HomeState {
  final AuthTokenModel? token;
  final List<Customer> customers;

  HomePageLoaded({ required this.token, required this.customers});
}

class HomePageError extends HomeState {
  final String message;

  HomePageError(this.message);
}