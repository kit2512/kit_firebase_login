import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_app/src/screens/screens.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required AuthenticationRepository authRepository})
      : _authRepository = authRepository,
        super(key: key);

  final AuthenticationRepository _authRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: BlocProvider(
        create: (_) => AppBloc(authenticationRepository: _authRepository),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlowBuilder<AppStatus>(
        state: context.read<AppBloc>().state.status,
        onGeneratePages: onGenerateAppPages,
      ),
    );
  }

  List<Page> onGenerateAppPages(AppStatus state, List<Page> pages) {
    switch (state) {
      case AppStatus.authenticated:
        return [HomeScreen.page()];
      case AppStatus.unauthenticated:
        return [LoginScreen.page()];
    }
  }
}
