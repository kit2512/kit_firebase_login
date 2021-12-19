part of 'login_cubit.dart';

class LoginState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus formStatus;
  final String? errorMessage;

  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.formStatus = FormzStatus.pure,
    this.errorMessage,
  });

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzStatus? formStatus,
    String? errorMessage,
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        email,
        password,
        formStatus,
        errorMessage,
      ];
}
