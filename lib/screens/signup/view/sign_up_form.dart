
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:myapp_nhat_2022/screens/login/login.dart';
import '../../../constants/colors.dart';
import '../../../constants/icons.dart';
import '../../../constants/images.dart';
import '../../../constants/screen_sizes.dart';
import '../../widgets/header.dart';
import '../cubit/sign_up_cubit.dart';

class SignUpForm extends StatelessWidget {
   const SignUpForm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: MyColors.primary,
      body:  BlocListener<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state.status.isSubmissionSuccess) {
              Navigator.of(context).pop();
            } else if (state.status.isSubmissionFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                      content: Text(state.errorMessage ?? 'Sign Up Failure')),
                );
            }
          },
          child: SafeArea(
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Header(
                            leftIcon: MyIcons.back,
                            onPressLeftIcon: () {
                              Navigator.pop(context);
                            },
                            rightIcon: MyIcons.menu,
                            onPressRightIcon: () => Navigator.push(
                              context, MaterialPageRoute(builder: (_)=> const LoginPage()),
                            ),
                            title: "Đăng ký",
                          ),
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
                            children: [
                              _EmailInput(),
                              const SizedBox(height: 8),
                              _PasswordInput(),
                              const SizedBox(height: 8),
                              _ConfirmPasswordInput(),
                              const SizedBox(height: 8),
                              _SignUpButton(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )))),
    );

  }

}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          style: const TextStyle(color:Colors.white,fontSize: 20),
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) {
            context.read<SignUpCubit>().emailChanged(email);
          },
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelStyle: const TextStyle(color:Colors.white,fontSize: 18),
            labelText: 'email',
            helperText: '',
            errorText: state.email.invalid ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          style: const TextStyle(color:Colors.white,fontSize: 20),
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            labelStyle: const TextStyle(color:Colors.white,fontSize: 18),
            labelText: 'password',
            helperText: '',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          style: const TextStyle(color:Colors.white,fontSize: 20),
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          onChanged: (confirmPassword) => context
              .read<SignUpCubit>()
              .confirmedPasswordChanged(confirmPassword),
          obscureText: true,
          decoration: InputDecoration(
            labelStyle: const TextStyle(color:Colors.white,fontSize: 18),
            labelText: 'confirm password',
            helperText: '',
            errorText: state.confirmedPassword.invalid
                ? 'passwords do not match'
                : null,
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
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
                    onPressed: () async =>{
                      if(  state.status.isValidated){
                        context.read<SignUpCubit>().signUpFormSubmitted(),
                      },
                //      Navigator.push(context, MaterialPageRoute(builder:(_)=> ProfileConfig(password: '1234', uid: '1234', email: '123456',))),
                    },
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
      },
    );
  }
}
