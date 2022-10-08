
import 'package:chat_demo/screens/OwnMessageCard.dart';
import 'package:chat_demo/screens/chat_screen.dart';
import 'package:chat_demo/screens/replyCard.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:chat_demo/models/chat_model.dart';

import 'API/constants.dart';
import 'classes/constantinfo.dart';
import 'models/group_id.dart';
import 'models/message_model.dart';
import 'models/send_msg.dart';

class ChatScreen extends StatefulWidget {
  late final int id;
  late final String name;
  late final int userid;
  ChatScreen({required Key key,required this.name,required this.id, required this.userid});

  //const userpage{Key? key;}) : super(key: key

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  //final ScrollController _scrollController = ScrollController();
  late final List<ChatModel> messages=[];
  ScrollController _scrollController = new ScrollController();

  void _scrollToBottom() {
    _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut
    );
  }

  bool _firstAutoscrollExecuted = false;
  bool _shouldAutoscroll = false;

  final bool _showSpinner = false;
  final bool _showVisibleWidget = false;
  final bool _showErrorIcon = false;

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    socket =
        IO.io("http://192.168.1.7:5000", <String, dynamic>{
          "transports": ["websocket"],
          "autoConnect": false,
        });

    socket.connect();
    socket.emit("signin", widget.id);
    socket.onConnect((data) {
      print("connected");
      socket.on("message", (msg) {
        print(data);
        setMessage("destination", msg["message"]);
      });
    });
  }


  //super.initState();


  void sendMessage(String msg, int targetId) {
    setMessage("source", msg);
    socket.emit("message",
        {"message": msg,"targetId": targetId});
  }

  void setMessage(String type, String msg) {
    ChatModel chatmodel = ChatModel(type: type, message: msg);
    setState(() {
      setState(() {
        messages.add(chatmodel);
      });
    });
  }


  // Listen to all message events from connected users
  void handleMessage(Map<String, dynamic> data) {
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      appBar: AppBar(

          centerTitle: true,
          title: Text(widget.name),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: choiceAction,
              itemBuilder: (BuildContext context) {
                return Constants.choices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),);
                })
                    .toList();
              }
              ,)
          ],

          backgroundColor: Color.fromRGBO(11, 1, 87, 0.89)),
      body: SafeArea(
        child: Container(
          color: Colors.grey.shade100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[


                 Flexible(
                   fit: FlexFit.loose,
                   child: ListView.builder(

                    controller: _scrollController,

                    //physics: const BouncingScrollPhysics(),
                    reverse: false,
                    itemCount: messages.length,
                    //shrinkWrap: true,
                    itemBuilder: (context, int index) {
                      if (messages[index].type == "source") {
                        return OwnMessageCard(
                          message: messages[index].message, key: Key("value"),);
                      }
                      else {
                        return ReplyCard(
                          message: messages[index].message, key: Key(""),);
                      }
                    },

                ),
                 ),


              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(
                      bottom: 10, left: 20, right: 20, top: 5),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          child: TextField(
                            minLines: 1,
                            maxLines: 5,
                            controller: _messageController,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: const InputDecoration.collapsed(
                              hintText: "Type a message",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),


                      SizedBox(
                        height: 43,
                        width: 42,
                        child: FloatingActionButton(
                          backgroundColor: const Color(0xFF271160),
                          onPressed: () async {
                            if (_messageController.text
                                .trim()
                                .isNotEmpty) {
                              _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeOut);
                              String message = _messageController.text.trim();
                              sendMessage(message, widget.id);
                              sendmsgmodel model = sendmsgmodel(
                                  messageGroupId: widget.id,
                                  message: message,
                                  way: 2,
                                  type: "text");
                              APIService.sendmsg(model);
                             _buildBody(context);

                              /* socket.emit(
                                  "/test",
                                  ChatModel(
                                      id: socket.id,
                                      message: message,
                                      //username: widget.username,
                                     // sentAt: DateTime.now()
                                        //  .toLocal()
                                      //    .toString()
                                      //    .substring(0, 16))
                                     // .toJson()
                              ).toJson()
                              );*/

                              _messageController.clear();
                            }
                          },
                          mini: true,
                          child: Transform.rotate(
                              angle: 5.79449,
                              child: const Icon(Icons.send, size: 20)),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.add) {

    }
    else if (choice == Constants.GroupInfo) {

    }
  }


  FutureBuilder<List<messageModel>> _buildBody(BuildContext context) {
    int x = widget.id;


    grpModel model = grpModel(id: widget.id);

    final APIService call = APIService();
    return FutureBuilder<List<messageModel>>(
      future: call.getmessage(model),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<messageModel>? posts = snapshot.data;

          return ListView.builder(
            itemCount: posts?.length,
            padding: EdgeInsets.all(5),
            itemBuilder: (context, index) {
              return SingleChildScrollView(

                child: Container(

                  color: Colors.grey.shade100,
                  child: Column(

                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,

                        children: [
                          ChatBubble(key: Key("value"),
                            message: posts![index].message!,
                            date: "",
                            isMe: posts[index].way!.isOdd,),
                        ],
                      ),


                    ],
                  ),
                ),
              );
            },
          );;
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

