
import 'package:chat_demo/models/app_theme.dart';
import 'package:chat_demo/models/idfetch.dart';
import 'package:chat_demo/screens/user_page.dart';
import 'package:chat_demo/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'API/constants.dart';
import 'classes/login_request_model.dart';



class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

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
      initialRoute: '/',

      title: _title,
      home: Scaffold(
        appBar: AppBar(title:  Text(_title,style: GoogleFonts.chivo()),),
        body:Container( constraints: BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("image/bg3.jpeg"),
                  fit: BoxFit.cover),),


          child:const LoginWidget(),),/* add child content here */
      ),

    );

  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<LoginWidget> {
  bool isApiCallProcess = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late String username=nameController.text,password=passwordController.text;
  final GlobalKey<FormState> _formKey =GlobalKey<FormState>();
  void _trySubmitForm(){
    final bool? isValid=_formKey.currentState?.validate();
    if (isValid == true){

      debugPrint('Everything looks good');
      debugPrint(username);
    }
  }
  @override
  Widget build(BuildContext context) {
    inAsyncCall: isApiCallProcess;
    return Padding(

      padding: const EdgeInsets.all(10),
      child: Form(

        key: _formKey,
        child: ListView(

          children: [

            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Chat App',
                style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              ),),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Login',
                style: TextStyle(fontSize:25,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                      ),

                validator: (value){
                  if(value==null||value.trim().isEmpty)
                  {
                    return 'Please Enter Username';
                  }
                  if(value.trim().length<2)
                  {
                    return 'Username must be at least 2 characters in length';
                  }
                  return null;
                },

              ),

            ),

            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextFormField(
                obscureText: true,
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

                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),

              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text('Forgot Password?',),
            ),

            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                  child: const Text('Login'),
                  onPressed: () {
                    if(_formKey.currentState!.validate() )

                    {
                      setState(() {
                        isApiCallProcess = true;
                      });

                    }
                    LoginRequestModel model = LoginRequestModel(
                      username: nameController.text,
                      password: passwordController.text,
                    );


                    APIService.Log(model).then(
                            (response) async {


                              setState(() {
                                isApiCallProcess = false;
                              });
                              if (response==false) {
                                await showDialog(

                                    context: context,
                                    builder: (context) => new AlertDialog(
                                  title: new Text('Message'),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                  content: Text(
                                      'User Does not exist'),
                                  actions: <Widget>[
                                    new FlatButton(
                                      onPressed: () {
                                        Navigator.of(context, rootNavigator: true)
                                            .pop(); // dismisses only the dialog and returns nothing
                                      },
                                      child: new Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                              }
                              else {

                                ipfetchModel ip = ipfetchModelFromJson(response);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => userpage(id: ip.Id, key: Key(""),)));
                                };
                              }
                            );


                  }),

            ),

                    //}
                    //else{
                      //print("enter right info");





            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {

                    Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
                    //signup screen
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
