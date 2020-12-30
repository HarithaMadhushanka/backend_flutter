import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:backend_flutter/widgets/gradient_button.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
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
  }
}
