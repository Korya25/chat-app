import 'package:chat_app/features/account/cubit/account_state.dart';
import 'package:chat_app/features/account/data/account_repositry.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountCubit extends Cubit<AccountState> {
  final AccountRepository _accountRepository;

  AccountCubit(this._accountRepository) : super(AccountInitial());

  // ✅ Clear error state
  void clearError() {
    emit(AccountInitial());
  }

  // ✅ Delete user account
  Future<void> deleteAccount(String password) async {
    emit(AccountLoading());
    try {
      await _accountRepository.deleteUserAccount(password);
      emit(AccountSuccess("Account deleted successfully."));
    } catch (e) {
      emit(AccountError(e.toString()));
    }
  }

  // ✅ Update password
  Future<void> updatePassword(String oldPassword, String newPassword) async {
    emit(AccountLoading());
    try {
      await _accountRepository.updatePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      emit(AccountPasswordUpdated());
    } catch (e) {
      emit(AccountError(e.toString()));
    }
  }

  // ✅ Process email update (handles both verification and update)
  Future<void> processEmailUpdate(
      String newEmail, String currentPassword) async {
    emit(AccountLoading());
    try {
      bool isVerified = await _accountRepository.requestEmailVerification(
          newEmail, currentPassword);
      if (isVerified) {
        bool isUpdated =
            await _accountRepository.confirmAndUpdateEmail(newEmail);
        if (isUpdated) {
          emit(AccountSuccess("Email updated successfully."));
        } else {
          emit(AccountError("Failed to update email."));
        }
      } else {
        emit(AccountError("Email verification failed."));
      }
    } catch (e) {
      emit(AccountError(e.toString()));
    }
  }

  // Update username
  Future<void> changeUsername(String newUsername) async {
    emit(AccountLoading());
    try {
      await _accountRepository.updateUsername(newUsername);
      emit(AccountSuccess("Username updated successfully"));
    } catch (e) {
      emit(AccountError(e.toString()));
    }
  }
}
