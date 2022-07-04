import 'package:chat_demo/login.dart';
import 'package:flutter/material.dart';
import 'package:chat_demo/login.dart';
import 'package:chat_demo/signup.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:chat_demo/models/app_theme.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  static const String _title = 'ChatApp';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: MyTheme.kPrimaryColor,
        accentColor: MyTheme.kAccentColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.deepPurple,
        appBarTheme: AppBarTheme(backgroundColor: Colors.deepPurple.shade900),
      ),
      title: _title,
      home: Scaffold(
        appBar: AppBar(title:  Text(_title,style: GoogleFonts.chivo())),
        body:Container( decoration: BoxDecoration(color: Colors.white),

          child:const SignWidget(),/* add child content here */
        ),

      ),
    );
  }
}

class SignWidget extends StatefulWidget {
  const SignWidget({Key? key}) : super(key: key);

  @override
  State<SignWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<SignWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String name='',password='',confirmpassword='';
  final GlobalKey<FormState> _formKey =GlobalKey<FormState>();
  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      debugPrint('Everything looks good');
      debugPrint(name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Chat App',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (value){
                    if(value==null||value.trim().isEmpty)
                    {
                      return 'Please Enter Username';
                    }
                    if(value.trim().length<4)
                    {
                      return 'Username must be at least 4 characters in length';
                    }
                    return null;
                  },
                  onChanged: (value) =>
                  name = value,

                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',

                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'This field is required';
                    }
                    if (value.trim().length < 8) {
                      return 'Password must be at least 8 characters in length';
                    }
                    // Return null if the entered password is valid
                    return null;
                  },
                  onChanged: (value) => password = value,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20,10),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }

                    if (value != password) {
                      return 'Confimation password does not match the entered password';
                    }

                    return null;
                  },
                  onChanged: (value) => confirmpassword = value,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
                  ),
                ),
              ),

              Container(
                  height: 70,
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Colors.red.shade300;
                          return Colors.deepPurple.shade800; // Use the component's default.
                        },
                      ),
                    ),
                    child: const Text('Sign Up'),
                    onPressed: () {
                      if(_formKey.currentState!.validate()
                      )
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));

                      }
                      else{
                        print("enter right info");
                      }

                    },
                  )
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    const Text('Have an account?'),
                    TextButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Login()));
                        //signup screen
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ],
          ),
        ));
  }
}
