
part of 'transfer_cubit.dart';
enum ConfirmPasswordValidationError { invalid }

class TransferState extends Equatable {
  const TransferState({
    this.money = '',
    this.account = '',
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final String money;
  final String account;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [money, account, status];

  TransferState copyWith({
    String? money,
    String? account,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return TransferState(
      money: money ?? this.money,
      account: account ?? this.account,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
