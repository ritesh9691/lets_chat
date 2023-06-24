
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lets_chat/models/chat_user.dart';
import 'package:lets_chat/widgets/chat_user_card.dart';

import '../apis/apis.dart';
import '../main.dart';
import 'auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // home icon
        leading: Icon(CupertinoIcons.home),
        // title of our app
        title: Text("Lets Chat"),
        actions: [
          // action buttons
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        //signout funtionality
        child: FloatingActionButton(
          onPressed: () async {
            await Apis.auth.signOut();
            await GoogleSignIn().signOut().then((value) =>
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginScreen())));
          },
          child: Icon(Icons.add_comment_rounded),
        ),
      ),
      // using streambuilder to get instant data from firestore
      body: StreamBuilder(
        // with streams we can acces the file we have created
        stream: Apis.firestore.collection("users").snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
            case ConnectionState.done:
            final data = snapshot.data?.docs;
            
            list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
           
            if(list.isNotEmpty){
                return ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: mq.height * .005),
                  physics: BouncingScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return ChatUserCard(user: list[index],);
                    
                  });
            }else{
              return Center(child: Text("No user Found!",style: TextStyle(fontSize: 20),));
            }
             
          }
        },
      ),
    );
  }
}
