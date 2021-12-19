import 'package:firebase_app/src/app/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static MaterialPage page() => MaterialPage(
        child: HomeScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Log ou"),
          onPressed: () {
            context.read<AppBloc>().add(AppLogOutRequested());
          },
        ),
      ),
    );
  }
}
