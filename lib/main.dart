import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/authentication/bloc/auth_bloc.dart';
import 'features/authentication/repositories/api_services.dart';
import 'features/onboarding/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiServices apiServices = ApiServices();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(apiServices)),
        // BlocProvider(create: (_) => ProfileBloc(apiServices)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        home: WelcomeScreen(),
      ),
    );
  }
}
