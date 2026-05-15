import 'package:flutter/foundation.dart';
import 'package:flutter_application_flextell_case/core/storage/secure_storage_service.dart';
import 'package:flutter_application_flextell_case/features/auth/bloc/Home_Bloc/home_event.dart';
import 'package:flutter_application_flextell_case/features/auth/bloc/Home_Bloc/home_state.dart';
import 'package:flutter_application_flextell_case/features/auth/data/repositories/customer_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final SecureStorageService storage;
  final CustomerRepository repository;

  HomeBloc(
    this.storage,
    this.repository,
  ) : super(HomePageLoading()) {

    on<LoadHomePageData>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(
    LoadHomePageData event,
    Emitter<HomeState> emit,
  ) async {

    debugPrint('HOME LOAD STARTED');

    emit(HomePageLoading());

    try {

      final tokens =
          await storage.getTokens();

      final customers =
          await repository.getCustomers();


      debugPrint('CUSTOMERS: ${customers.length}');

      emit(
        HomePageLoaded(
          token: tokens,
          customers: customers,
        ),
      );

    } catch (e) {

      emit(HomePageError(e.toString()));
    }
  }
}