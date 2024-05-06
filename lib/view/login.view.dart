import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/common/constants.dart';
import 'package:smartproduction_planorama/providers/login.controller.provider.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
              top: -219,
              left: -176,
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Container(
                decoration: BoxDecoration(
                  color: HexColors().tertiaryColor.shade900,
                  shape: BoxShape.circle
                ),
              )
          ),
          Positioned(
              bottom: 0,
              right: -250,
              child: Image.asset(
                height: MediaQuery.of(context).size.width * 0.25,
                fit: BoxFit.fill,
                'assets/images/logo/20_Logo_Transparent.png'
              )
          ),
          Center(
            child: Container(
              width: 601,
              height: 621,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: HexColors().secondColor.shade900,
              ),
              padding: const EdgeInsets.all(64),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      style: TextStyle(
                        fontSize: 64,
                        color: Colors.white
                      ),
                      'Planorama'
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'E-Mail',
                      ),
                      style: const TextStyle(
                        color: Colors.white
                      ),
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      style: const TextStyle(
                        color: Colors.white
                      ),
                    ),
                    SizedBox(
                      width: 424,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          ref.read(loginControllerProvider.notifier).login(emailController.text, passwordController.text);
                        },
                        child: const Text(
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14
                          ),
                          'Login'
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
