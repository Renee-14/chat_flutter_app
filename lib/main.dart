
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
      /*theme: ThemeData(
        primaryColor: MyTheme.kPrimaryColor,
        accentColor: MyTheme.kAccentColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.deepPurple,
        appBarTheme: AppBarTheme(backgroundColor: Colors.deepPurple.shade800),
      ),
      title: _title,*/
      home: Scaffold(
        //appBar: AppBar(title:  Text(_title,style: GoogleFonts.chivo(),),),
        body:Container( constraints: BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("image/bg3.jpeg"),
                  fit: BoxFit.cover),
            )
        ,child:const FirstWidget(),),
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
    return Stack(

            children: <Widget>[

              Positioned(
                top: 200,


                child: Container(

                  width: MediaQuery.of(context).size.width,


                  child:  Text(
                    'WELCOME!'
                        '\nTO THE ChatApp',
                    style: GoogleFonts.belleza(textStyle: TextStyle(
                      color: Color.fromRGBO(3, 27, 135, 0.80),
                      fontWeight: FontWeight.w700,
                      fontSize: 36,),),

                  textAlign: TextAlign.center,),),
              ),

              Positioned(
                height: 500,
                width: MediaQuery.of(context).size.width,
                bottom: 0,
                child: Container(
                    margin: EdgeInsets.all(5),

                  width: MediaQuery.of(context).size.width,

                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                     children: [

                        Padding(
                          padding: const EdgeInsets.all(17.0),
                          child: SizedBox(
                           width: 150,height: 46,
                            child: ElevatedButton(
                                style: ButtonStyle(

                                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                      if (states.contains(MaterialState.pressed))
                                        return Colors.red.shade300;
                                      return Color.fromRGBO(11, 1, 87, 0.85); // Use the component's default.
                                    },
                                  ),
                                ),
                                child: Text('Login',style: TextStyle(fontSize: 20,)),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context){
                                        return Login();

                                      }
                                      ));

                                }
                            ),
                          ),
                        ),

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        width: 150,height: 46,
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
                                child: const Text('Signup',style: TextStyle(fontSize: 20),),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const Signup()));
                                }



                ),
                      ),
                    ),

],

          ),
                  )),
              ),
           ],

    );
  }
}
