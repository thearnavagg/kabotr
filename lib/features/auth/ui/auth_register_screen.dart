import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kabotr/features/auth/bloc/auth_bloc.dart';
import 'package:kabotr/themes/app_colors.dart';
import 'package:kabotr/themes/app_images.dart';

class AuthRegisterScreen extends StatefulWidget {
  const AuthRegisterScreen({super.key});

  @override
  State<AuthRegisterScreen> createState() => _AuthRegisterScreenState();
}

class _AuthRegisterScreenState extends State<AuthRegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = const Key('form');
  bool isLogin = true;
  AuthBloc authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listenWhen: (previous, current) => current is AuthActionState,
        buildWhen: (previous, current) => current is! AuthActionState,
        listener: (context, state) {
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is AuthSuccessState) {
            Navigator.popUntil(context, (route) => route.isFirst);
          }
        },
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(AppImages.logoTextWhite),
              SizedBox(height: 5),
              Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isLogin) const Text('Name'),
                      if (!isLogin)
                        TextFormField(
                          controller: nameController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter Your Name";
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: "Enter Your Name..",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2.0)),
                          ),
                        ),
                      const SizedBox(height: 10),
                      const Text('Email'),
                      TextFormField(
                        controller: emailController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Your Email";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: "Enter Your Email..",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.7)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1.4)),
                        ),
                      ),
                      SizedBox(height: 10),
                      const Text('Password'),
                      TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Your Password";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: "Enter Your Password..",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2.0)),
                        ),
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                          height: 45,
                          width: double.maxFinite,
                          child: ElevatedButton(
                              onPressed: () {
                                authBloc.add(AuthenticationEvent(
                                    authType: isLogin
                                        ? AuthType.login
                                        : AuthType.register,
                                    email: emailController.text,
                                    password: passwordController.text));
                              },
                              child: Text(isLogin ? "Login" : "Register"))),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(isLogin
                              ? "Don't have an account?"
                              : "Already have an account?"),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  isLogin = !isLogin;
                                });
                              },
                              child: Text(
                                isLogin ? " Register" : " Login",
                                style: TextStyle(color: AppColor.purple),
                              ))
                        ],
                      )
                    ]),
              ),
            ]),
          );
        },
      ),
    );
  }
}
