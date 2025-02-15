import 'package:chat_app/features/auth/cubit/auth_state.dart';
import 'package:chat_app/features/auth/data/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(const AuthInitial());

  // clear the error message
  void clearError() {
    emit(const AuthInitial());
  }

  // Check if user is already logged in
  void checkUserStatus() {
    User? user = _authRepository.getCurrentUser();
    if (user != null) {
      emit(AuthSuccess(user));
    } else {
      emit(const AuthLoggedOut());
    }
  }

  // Sign In
  Future<void> signIn({required String email, required String password}) async {
    emit(const AuthLoading());
    try {
      User? user = await _authRepository.signIn(email, password);
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(const AuthError("Invalid credentials"));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError("Auth Error: ${e.message}"));
    } catch (e) {
      emit(AuthError("Unexpected Error: $e"));
    }
  }

  // Sign Up
  Future<void> signUp(
      {required String email,
      required String password,
      required String userName}) async {
    emit(const AuthLoading());
    try {
      User? user = await _authRepository.signUp(
          email: email, password: password, userName: userName);
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(const AuthError("Failed to register"));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError("Auth Error: ${e.message}"));
    } catch (e) {
      emit(AuthError("Unexpected Error: $e"));
    }
  }

  // Sign Out
  Future<void> signOut() async {
    emit(const AuthLoading());

    try {
      await _authRepository.signOut();
      emit(const AuthLoggedOut());
    } catch (e) {
      emit(AuthError("Failed to log out"));
    }
  }

  // Reset Password
  Future<void> resetPassword({required String email}) async {
    emit(const AuthLoading());
    try {
      await _authRepository.resetPassword(email);
      emit(const AuthPasswordResetSuccess());
    } catch (e) {
      if (e.toString().contains("Email is not registered")) {
        emit(AuthPasswordResetError(
            "Email is not registered go to sign up page"));
      } else {
        emit(AuthPasswordResetError("Failed to send password reset email"));
      }
    }
  }
}
