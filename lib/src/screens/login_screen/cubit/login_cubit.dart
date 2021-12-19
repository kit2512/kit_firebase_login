import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:firebase_app/src/screens/login_screen/form_validator/form_validator.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository authenticationRepository;

  LoginCubit(this.authenticationRepository) : super(const LoginState());

  onEmailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        formStatus: Formz.validate([email, state.password]),
      ),
    );
  }

  onPasswordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        formStatus: Formz.validate([state.email, password]),
      ),
    );
  }

  onLogin() {
    if (state.formStatus == FormzStatus.invalid) {
      return;
    }
    emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
    try {
      authenticationRepository.logInWithEmailAndPassword(
        state.email.value,
        state.password.value,
      );
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(
        formStatus: FormzStatus.submissionFailure,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          formStatus: FormzStatus.submissionFailure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
