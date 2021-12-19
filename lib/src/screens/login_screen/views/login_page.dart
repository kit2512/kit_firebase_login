import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_app/src/screens/login_screen/views/login_form.dart';
import 'package:firebase_app/src/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static MaterialPage page() => MaterialPage(
        child: LoginScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: BlocProvider(
            create: (context) =>
                LoginCubit(context.read<AuthenticationRepository>()),
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}
