abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountSuccess extends AccountState {
  final String message;

  AccountSuccess(this.message);
}

class AccountPasswordUpdated extends AccountState {}

class AccountEmailVerificationSent extends AccountState {
  final String message;
  AccountEmailVerificationSent(this.message);
}

class AccountError extends AccountState {
  final String error;
  AccountError(this.error);
}
