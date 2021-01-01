import 'package:backend_flutter/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:backend_flutter/blocs/authentication_bloc/authentication_event.dart';
import 'package:backend_flutter/blocs/login_bloc/login_bloc.dart';
import 'package:backend_flutter/blocs/login_bloc/login_event.dart';
import 'package:backend_flutter/blocs/login_bloc/login_state.dart';
import 'package:backend_flutter/repositories/user_repository.dart';
import 'package:backend_flutter/screens/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:backend_flutter/widgets/gradient_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  const LoginForm({Key key, UserRepository userRepository}) : _userRepository = userRepository, super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  LoginBloc _loginBloc;

 @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state){

        if(state.isFailure) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Logging Failure..."),
                  Icon(Icons.error),
                ],
              ),
              backgroundColor: Colors.black45,
            ));
          print("state is : " + state.toString());
        }
        if(state.isSubmitting) {
          Scaffold.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Logging In..."),
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
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state){
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
                        autocorrect: false,
                        obscureText: true,
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
                    if(isButtonEnabled(state)) {
                      _onFormSubmitted();
                    }
                  },
                  text: Text('Login', style: TextStyle(
                    fontSize: 17,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  ),
                  icon: Icon(
                    Icons.check,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 15,),
                GradientButton(
                  width: 135,
                  height: 42,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_){
                      return RegisterScreen(userRepository: widget._userRepository,);
                    }
                    ));
                  },
                  text: Text('Register', style: TextStyle(
                    fontSize: 17,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  ),
                  icon: Icon(
                    Icons.arrow_forward,
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

  @override
  void dispose() {
   _emailController.dispose();
   _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChange() {
   _loginBloc.add(
     LoginEmailChange(email: _emailController.text)
   );
  }

  void _onPasswordChange() {
    _loginBloc.add(
        LoginPasswordChanged(password: _passwordController.text)
    );
  }

  void _onFormSubmitted() {
   _loginBloc.add(
     LoginWithCredentialsPressed(
       email: _emailController.text, password: _passwordController.text,
     )
   );
  }
}
