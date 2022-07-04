
import 'package:chat_demo/firstpage.dart';
import 'package:chat_demo/login.dart';
import 'package:chat_demo/models/app_theme.dart';
import 'package:chat_demo/signup.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Chat App';

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
        appBar: AppBar(title:  Text(_title,style: GoogleFonts.chivo(),),),
        body:Container( decoration: BoxDecoration(color: Colors.grey.shade50),child:const FirstWidget(),),
        /* add child content here */
      ),

    );

  }
}

class FirstWidget extends StatefulWidget {
  const FirstWidget({Key? key}) : super(key: key);

  @override
  State<FirstWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<FirstWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[

            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(50, 140, 50, 0),
              child:  Text(
                'Welcome!'
                    '\nTo ChatApp',
                style: GoogleFonts.raleway(textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 30,),),

              ),),
            Container(
              padding: EdgeInsets.all(30),
              child: Image.asset('image/K85.jpg',width: 100,height: 100,colorBlendMode: BlendMode.colorDodge,),),


            Container(

                height: 100,
                padding: const EdgeInsets.fromLTRB(80,50,80,0),
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
                    child: const Text('Login'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context){
                            return Login();

                          }
                          ));

                    }
                )
            ),
            Container(

                height: 80,
                padding: const EdgeInsets.fromLTRB(80,30, 80,0),
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
                    child: const Text('Signup'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Signup()));
                    }
                )
            ),

          ],
        ));
  }
}
