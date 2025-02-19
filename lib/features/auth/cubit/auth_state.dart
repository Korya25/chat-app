import 'package:chat_app/features/auth/data/models/user_model.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  final UserModel user;
  const AuthSuccess(this.user);
}

class AuthLoggedOut extends AuthState {
  const AuthLoggedOut();
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}

class AuthPasswordResetSuccess extends AuthState {
  const AuthPasswordResetSuccess();
}

class AuthPasswordResetError extends AuthState {
  final String message;
  const AuthPasswordResetError(this.message);
}
