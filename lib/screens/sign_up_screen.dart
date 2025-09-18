import 'package:firebase_auth_flutter/bloc/auth_bloc.dart';
import 'package:firebase_auth_flutter/bloc/auth_state.dart';
import 'package:firebase_auth_flutter/screens/login_screen.dart';
import 'package:firebase_auth_flutter/util/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../bloc/auth_event.dart';
import '../util/app_colors.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,

                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          TweenAnimationBuilder(
                            builder: (context, value, child) {
                              return Transform.translate(
                                offset: Offset(0, value),
                                child: Opacity(
                                  opacity: 1 - (value.abs() / 20),
                                  child: child,
                                ),
                              );
                            },
                            tween: Tween<double>(begin: -20, end: 0),
                            duration: Duration(milliseconds: 600),
                            curve: Curves.easeOut,
                            child: SvgPicture.asset(
                              'assets/shn_logo.svg',
                              width: 100,
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Create your Account',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Name',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'John Deo',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.lightGreyColor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          // Border when focused
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          // Border when not focused
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Email Address',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: emailController,
                      validator: Validators.validateEmail,
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'example@gmail.com',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.lightGreyColor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          // Border when focused
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          // Border when not focused
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    const Text(
                      'Password',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      validator: Validators.validatePassword,
                      obscureText: true,
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: '********',
                        hintStyle: const TextStyle(
                          letterSpacing: 5,
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.lightGreyColor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          // Border when focused
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          // Border when not focused
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Material(
                      color: Colors.black, // Button background
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        // Ripple shape
                        splashColor: Colors.white.withOpacity(0.3),
                        // Ripple color
                        onTap: () {
                          context.read<AuthBloc>().add(
                            SignUpRequested(
                              emailController.text,
                              passwordController.text,
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 17),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Log in',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
