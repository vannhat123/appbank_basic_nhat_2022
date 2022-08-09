import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part "transfer_state.dart";

class TransferCubit extends Cubit<TransferState> {
  TransferCubit(this._authenticationRepository) : super(const TransferState());

  final AuthenticationRepository _authenticationRepository;

  void moneyChanged(String value) {
    emit(
      state.copyWith(
        money: value,
      ),
    );
  }

  void accountChange(String value) {
    emit(
      state.copyWith(
        account: value,
      ),
    );
  }

  // void confirmedAccount(String value) {
  //     FirebaseFirestore.instance.collection(value).doc(0).snapshots().
  // }
  //
  // Future<void> signUpFormSubmitted() async {
  //   if (!state.status.isValidated) return;
  //   emit(state.copyWith(status: FormzStatus.submissionInProgress));
  //   try {
  //     await _authenticationRepository.signUp(
  //       email: state.email.value,
  //       password: state.password.value,
  //     );
  //     await FirebaseFirestore.instance.collection(state.email.value).doc(state.email.value).set({
  //       'id': state.email.value,
  //       'email': state.email.value,
  //       'createdAt': Timestamp.now(),
  //     });
  //     emit(state.copyWith(status: FormzStatus.submissionSuccess));
  //   } on SignUpWithEmailAndPasswordFailure catch (e) {
  //     emit(
  //       state.copyWith(
  //         errorMessage: e.message,
  //         status: FormzStatus.submissionFailure,
  //       ),
  //     );
  //   } catch (_) {
  //     emit(state.copyWith(status: FormzStatus.submissionFailure));
  //   }
  // }
  //
  // Future<void> signUpProfileSubmitted() async {
  //   return
  //     emit(state.copyWith(status: FormzStatus.submissionSuccess));
  // }
}
