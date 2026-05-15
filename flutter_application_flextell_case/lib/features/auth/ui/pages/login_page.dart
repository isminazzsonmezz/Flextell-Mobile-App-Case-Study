import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_flextell_case/core/storage/secure_storage_service.dart';
import 'package:flutter_application_flextell_case/features/auth/bloc/Auth_Bloc/auth_bloc.dart';
import 'package:flutter_application_flextell_case/features/auth/bloc/Auth_Bloc/auth_event.dart';
import 'package:flutter_application_flextell_case/features/auth/bloc/Auth_Bloc/auth_state.dart';
import 'package:flutter_application_flextell_case/features/auth/bloc/Home_Bloc/home_bloc.dart';
import 'package:flutter_application_flextell_case/features/auth/bloc/Home_Bloc/home_event.dart';
import 'package:flutter_application_flextell_case/features/auth/data/repositories/customer_repository.dart';
import 'package:flutter_application_flextell_case/features/auth/ui/pages/home_page.dart';
import 'package:flutter_application_flextell_case/features/auth/ui/widgets/custom_appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  DateTime? _lastBackPressed;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final scale = width / 375;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        final now = DateTime.now();

        if (_lastBackPressed == null ||
            now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
          _lastBackPressed = now;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Press again to exit."),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(title: "Login"),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {

            if (state is AuthAuthenticated) {

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(

                  builder: (_) => BlocProvider(

                    create: (_) => HomeBloc(
                      SecureStorageService(),
                      CustomerRepository(),
                    )..add(
                        LoadHomePageData(),
                      ),

                    child: const HomePage(),
                  ),
                ),
              );
            }

            if (state is AuthError) {

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },

          child: LoginView(scale: scale),
        )
      ),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key, required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Flextell',
            style: TextStyle(fontSize: 32 * scale, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10 * scale),
          Text('Secure Customer Management'),
          SizedBox(height: 25 * scale),
          ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(LoginRequested());
            },
            child: Text('Login with Flextell'),
          ),
        ],
      ),
    );
  }
}
