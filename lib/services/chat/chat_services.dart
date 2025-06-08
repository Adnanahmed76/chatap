import 'package:chatap/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatServices {
  //get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
// get user stream

/* List<Map<String,dynmaic>
{
'email: 'test@gmail.com
'id':""
*/

  //get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        //go through each individual user
        final user = doc.data();

        //return user
        return user;
      }).toList();
    });
  }

  //send message
  Future<void> sendMessage(String receiverId, message) async {
//get current user info
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
//create a new message
    Message newMessage = Message(
        message: message,
        receiverID: receiverId,
        senderEmail: currentUserId,
        senderId: currentUserEmail,
        timestamp: timestamp);
//contruct chat from id for the two users (sorted to ensure uniques)
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); //sort the ids (this ensure the chatroomid is the same for any 2 people)
    String chatRoomID = ids.join("_");
    //added new message to database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("message")
        .add(newMessage.toMap());
  }

  //get messages
  Stream<QuerySnapshot> getMessages(String UserId, otherUserId) {
    List<String> ids = [UserId, otherUserId];
    String chatRoomId = ids.join("_");
    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("message")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
