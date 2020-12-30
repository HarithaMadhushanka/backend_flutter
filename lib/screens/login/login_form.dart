import 'package:backend_flutter/screens/register/register_form.dart';
import 'package:backend_flutter/screens/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:backend_flutter/widgets/gradient_button.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

 @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: "Email",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autovalidate: true,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: "Password"
                  ),
                  autovalidate: true,
                  obscureText: true,
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          GradientButton(
            width: 135,
            height: 42,
            onPressed: (){},
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
                return RegisterScreen();
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
  }
}
