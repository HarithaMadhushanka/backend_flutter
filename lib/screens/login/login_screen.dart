import 'package:backend_flutter/blocs/login_bloc/login_bloc.dart';
import 'package:backend_flutter/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  const LoginScreen({Key key, UserRepository userRepository}) : _userRepository = userRepository, super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.green.withOpacity(0.8), Colors.blue.withOpacity(0.8)],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 180, left: 15),
                    child: Text('Login', style: GoogleFonts.aBeeZee(fontSize: 45),
                    ),
                  ),
                  LoginForm(
                    userRepository: _userRepository,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}