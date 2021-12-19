import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

import 'src/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final AuthenticationRepository authRepository = AuthenticationRepository();
  await authRepository.user.first;
  BlocOverrides.runZoned(() => runApp(MyApp(authRepository: authRepository)),
      blocObserver: AppBlocObserver());
}
