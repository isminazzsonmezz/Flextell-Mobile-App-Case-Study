import 'package:flutter/material.dart';
import 'package:flutter_application_flextell_case/core/network/dio_client.dart';
import 'package:flutter_application_flextell_case/core/storage/secure_storage_service.dart';
import 'package:flutter_application_flextell_case/features/auth/bloc/Auth_Bloc/auth_bloc.dart';
import 'package:flutter_application_flextell_case/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_application_flextell_case/features/auth/data/services/auth_service.dart';
import 'package:flutter_application_flextell_case/features/auth/data/services/refreshToken.dart';
import 'package:flutter_application_flextell_case/features/auth/ui/pages/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final refreshtokenService = Refreshtoken(DioClient.dioIntance);
    final securestorage = SecureStorageService();

    final authRepository = AuthRepository(authService,  refreshtokenService ,securestorage);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: BlocProvider(
        create: (_) => AuthBloc(authRepository),
        child: const LoginPage(),
      ),
    );
  }
}
