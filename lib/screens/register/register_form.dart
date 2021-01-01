import 'package:backend_flutter/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:backend_flutter/blocs/authentication_bloc/authentication_event.dart';
import 'package:backend_flutter/blocs/register_bloc/register_bloc.dart';
import 'package:backend_flutter/blocs/register_bloc/register_event.dart';
import 'package:backend_flutter/blocs/register_bloc/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:backend_flutter/widgets/gradient_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatefulWidget {

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state){
        if(state.isFailure) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Register Failure..."),
                  Icon(Icons.error),
                ],
              ),
              backgroundColor: Colors.black45,
            ));
        }

        if(state.isSubmitting) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Registering..."),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ],
              ),
              backgroundColor: Colors.black45,
            ));
        }

        if(state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLoggedIn(),);
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          icon: Icon(Icons.email),
                          labelText: "Email",
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autovalidate: true,
                        autocorrect: false,
                        validator: (_) {
                          return !state.isEmailValid ? 'Invalid Email' : null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            labelText: "Password"
                        ),
                        autovalidate: true,
                        obscureText: true,
                        autocorrect: false,
                        validator: (_) {
                          return !state.isPasswordValid ? 'Invalid Password' : null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                GradientButton(
                  width: 135,
                  height: 42,
                  onPressed: (){
                    if(isButtonEnabled(state)){
                      _onFormSubmitted();
                    }
                  },
                  text: Text('Register', style: TextStyle(
                    fontSize: 17,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  ),
                  icon: Icon(
                    Icons.check,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onEmailChange() {
    _registerBloc.add(
        RegisterEmailChanged(email: _emailController.text)
    );
  }

  void _onPasswordChange() {
    _registerBloc.add(
        RegisterPasswordChanged(password: _passwordController.text)
    );
  }

  void _onFormSubmitted() {
    _registerBloc.add(
        RegisterSubmitted(
          email: _emailController.text, password: _passwordController.text,
        )
    );
  }
}
