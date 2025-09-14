import 'package:animations/animations.dart';
import 'package:firebase_auth_flutter/bloc/auth_bloc.dart';
import 'package:firebase_auth_flutter/bloc/auth_state.dart';
import 'package:firebase_auth_flutter/repository/auth_repository.dart';
import 'package:firebase_auth_flutter/screens/home_screen.dart';
import 'package:firebase_auth_flutter/screens/login_screen.dart';
import 'package:firebase_auth_flutter/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository = AuthRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(authRepository),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: SharedAxisPageTransitionsBuilder(
                transitionType: SharedAxisTransitionType.horizontal,
              ),
            },
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return HomeScreen();
            } else if (state is AuthUnauthenticated) {
              return LoginScreen();
            } else if (state is AuthLoading) {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }
            return SplashScreen();
          },
        ),
      ),
    );
  }
}
