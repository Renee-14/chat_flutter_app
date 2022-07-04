import 'dart:ffi';

import 'package:chat_demo/models/app_theme.dart';
import 'package:chat_demo/models/user_model.dart';

import 'package:chat_demo/models/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'chat_screen.dart';


class page extends StatelessWidget {
  const page({Key? key}) : super(key: key);

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
        body:Container( decoration: BoxDecoration(image: DecorationImage( image: const AssetImage("image/bg.jpg"),fit: BoxFit.cover)),

          child:const FirstPage(),/* add child content here */
        ),

      ),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<FirstPage> with TickerProviderStateMixin{
  TextEditingController nameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;

  void startChat() {

      setState(() {
        _isLoading = true;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _isLoading = false;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(
                  username: _nameController.text.trim(), key: Key("value"),
                )));
      });

  }
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(

        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),),
        title: Text('ChatApp',style: GoogleFonts.chivo()),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt_rounded))
        ],


        elevation: 0,
      ),


      body: Column(

        children: [
          Container(
            decoration: BoxDecoration(color: Colors.deepPurple.shade900,

            ),
            child: Text('CHATS',style: GoogleFonts.chivo(textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 20,),),),
            height: 40,

            alignment: Alignment(0,0),
          ),


          Container(

              padding: EdgeInsets.symmetric(horizontal:7 ,vertical: 5),

              decoration: BoxDecoration(border: Border.all(color: Colors.white10,width: 0.2,),color: Colors.deepPurple.shade100.withOpacity(0.1),),
              child: (

                  ListView.builder(shrinkWrap: true,
                      itemCount: CurrentUser.length,
                      itemBuilder: (context, int index) {
                        final users = CurrentUser[index];

                        return Container(

                            decoration: BoxDecoration(border: Border.all(color: Colors.white10,width: 0.2,),color: Colors.white.withOpacity(0.4),borderRadius: BorderRadius.circular(7),),
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            margin: const EdgeInsets.symmetric(vertical: 2,horizontal: 0),


                            child: GestureDetector(
                              onTap: startChat,
                              child: Row(

                                children: [CircleAvatar(radius: 25,backgroundImage: AssetImage(users.avatar),),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:[
                                      Text(users.name,style: GoogleFonts.chivo(textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,),),)
                                      ,],),

                                ],

                              ),
                            )

                        );

                      })

              )
          ),],
      ),
      floatingActionButton: FloatingActionButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),onPressed: () {  },
        child: Icon(Icons.messenger_outline,color: Colors.white),),
    );

  }
}
