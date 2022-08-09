
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:myapp_nhat_2022/constants/constants.dart';
import 'package:myapp_nhat_2022/screens/widgets/google_button.dart';

import '../../signup/view/sign_up_page.dart';
import '../cubit/login_cubit.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status.isSubmissionFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content:
                    Text(state.errorMessage ?? 'Authentication Failure'),
                  ),
                );
            }
          },
            child: SafeArea(
                child: Form(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: getHeight(200),
                                  child: Center(
                                    child: Image.asset(
                                      MyImages.logowhite,
                                      scale: getWidth(0.9),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 16),
                                    _EmailInput(),
                                    const SizedBox(height: 8),
                                    _PasswordInput(),
                                    const SizedBox(height: 8),
                                    _LoginButton(),
                                    const SizedBox(height: 8),
                                    const GoogleButton(),
                                    const SizedBox(height: 4),
                                    _SignUpButton(),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )))),
          ),
    );
  }
}
class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          style: const TextStyle(color:Colors.white,fontSize: 20),
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelStyle: const TextStyle(color:Colors.white,fontSize: 18),
            labelText: 'email',
            helperText: '',
            errorText: state.email.invalid ? 'invalid email' : null,
            enabledBorder:  OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(15)
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          style: const TextStyle(color:Colors.white,fontSize: 20),
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            labelStyle: const TextStyle(color:Colors.white,fontSize: 18),
            labelText: 'password',
            helperText: '',
            errorText: state.password.invalid ? 'invalid password' : null,
            enabledBorder:  OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(15)
            ),
          ),
        );
      },
    );
  }
}



class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : SizedBox(
            width: double.infinity,
            height: 70,
            child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  primary: Colors.black,
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.indigoAccent),
                ),
                onPressed: state.status.isValidated
                    ? () => context.read<LoginCubit>().logInWithCredentials()
                    : null,
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Center(
                      child: Text(
                        "Đăng nhập",
                        style: TextStyle(
                            color: Colors.indigoAccent,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ))));
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 70,
        child: TextButton(
            key: const Key('loginForm_createAccount_flatButton'),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              primary: Colors.black,
              backgroundColor: Colors.white,
              side: const BorderSide(color: Colors.indigoAccent),
            ),
            onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const Center(
                  child: Text(
                    "Đăng ký ngay",
                    style: TextStyle(
                        color: Colors.indigoAccent,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ))));
  }
}

