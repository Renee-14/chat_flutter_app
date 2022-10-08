import 'package:chat_demo/login.dart';
import 'package:chat_demo/screens/reg_success.dart';
import 'package:flutter/material.dart';
import 'package:chat_demo/login.dart';
import 'package:chat_demo/signup.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:chat_demo/models/app_theme.dart';

import 'API/constants.dart';
import 'classes/register_request_model.dart';

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
        primarySwatch: Colors.indigo,
        appBarTheme: AppBarTheme(backgroundColor: Color.fromRGBO(11, 1, 87, 0.89)),
      ),
      title: _title,
      home: Scaffold(
        appBar: AppBar(title:  Text(_title,style: GoogleFonts.chivo())),
        body:Container( constraints: BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("image/bg3.jpeg"),
                  fit: BoxFit.cover),
            ),

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
  bool isApiCallProcess = false;
  bool hidePassword = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController= TextEditingController();

  late String username=nameController.text,
      password=passwordController.text,
      firstname=firstnameController.text,
      lastname=lastnameController.text;
  final GlobalKey<FormState> _formKey =GlobalKey<FormState>();
  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      debugPrint('Everything looks good');
      debugPrint(username);
    }
  }
  String? gender;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15),
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
                        color: Colors.indigo,
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
                  username = value,

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
                  keyboardType: TextInputType.text,
                  validator: (value){
                    if(value==null||value.trim().isEmpty)
                    {
                      return 'Please Enter Username';
                    }
                    return null;

                  },
                  onChanged: (value) =>
                  firstname = value,

                  controller: firstnameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'First Name',

                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (value){
                    if(value==null||value.trim().isEmpty)
                    {
                      return 'Please Enter Username';
                    }
                    return null;

                  },
                  onChanged: (value) =>
                  lastname= value,

                  controller: lastnameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Last Name',

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
              Text("Gender",style: TextStyle(fontSize: 15),),
              ListTile(
                title: Text("Male"),
                leading: Radio(
                    value: "male",
                    groupValue: gender,
                    onChanged: (value){
                      setState(() {
                        gender = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: Text("Female"),
                leading: Radio(
                    value: "Female",
                    groupValue: gender,
                    onChanged: (value){
                      setState(() {
                        gender = value.toString();
                      });
                    }),
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
                          return Color.fromRGBO(11, 1, 87, 0.89); // Use the component's default.
                        },
                      ),
                    ),
                    child: const Text('Sign Up'),
                    onPressed: () {
                      if(_formKey.currentState!.validate()
                      )
                      {
                        setState(() {
                          isApiCallProcess = true;
                        });

                        RegisterRequestModel model = RegisterRequestModel(
                          username: username,
                          password: password,
                          firstname: firstname,
                          lastname: lastname,
                        );

                        APIService.register(model).then(
                              (response) {
                                setState(() {
                                  isApiCallProcess = false;
                                });

                                if (response==true) {

                                      Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => reg()));

                                  };


                              });

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
                        style: TextStyle(fontSize: 25),
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
