import 'package:firebase_app/src/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.formStatus.isSubmissionFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
            ),
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Login",
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16.0),
          _EmailInput(),
          const SizedBox(height: 16.0),
          _PassowrdInput(),
          const SizedBox(height: 16.0),
          _LoginButton(),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: "Email",
            errorText: state.email.invalid ? "Invalid Email" : null,
          ),
          onChanged: context.read<LoginCubit>().onEmailChanged,
        );
      },
    );
  }
}

class _PassowrdInput extends StatelessWidget {
  const _PassowrdInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: "Password",
            errorText: state.password.invalid ? "Invalid Password" : null,
          ),
          onChanged: context.read<LoginCubit>().onPasswordChanged,
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (_, state) {
        if (state.formStatus == FormzStatus.submissionInProgress) {
          return const CircularProgressIndicator();
        } else {
          return ElevatedButton(
            child: const Text("Login"),
            onPressed: state.formStatus.isValid
                ? context.read<LoginCubit>().onLogin
                : null,
          );
        }
      },
    );
  }
}
