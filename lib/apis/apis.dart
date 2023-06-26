import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lets_chat/models/chat_user.dart';

class Apis {
  // for the authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  // for accessing the firebaseFirestore
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User get user => auth.currentUser!;
  static late ChatUser me;
  //check wheather user exist or not
  // if user is already having the data then go to user and then collection of uid and give true or false
  static Future<bool> userExist() async {
    return (await firestore.collection("users").doc(user.uid).get()).exists;
  }
// making an method to get the current user data 
// from user to the doc and then find the uid from that 
// if not found then we have to make it by calling it in chatuser again
  static Future<void> getSelfInfo() async {
    await firestore.collection("users").doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
        log("data of me :${user.data().toString()}");
      }else{
        await createUser().then((user) => getSelfInfo());
      }
    });
  }

  //upload the chatuser to firestore
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch;
    // now we need to add the user data
    // we will pass the data given from auth.current user to pass in firestore chatuser data
    final chatUser = ChatUser(
      id: user.uid,
      name: user.displayName,
      email: user.email,
      about: "hello i am a testing app",
      image: user.photoURL.toString(),
      createdAt: time.toString(),
      isOnline: false,
      lastActive: time.toString(),
      pushToken: "",
    );
    // after setting the vslue in chatuser class we will call the tojson in set method to send the data to server.
    return (await firestore
        .collection("users")
        .doc(user.uid)
        .set(chatUser.toJson()));
  }

// for geeting all the user data exept our
// data type to snapshot---{stream<quary...}
// this will help us to get only other user's data that we want to show on the screen 
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection("users")
        .where("id", isNotEqualTo: user.uid)
        .snapshots();
  }
}
