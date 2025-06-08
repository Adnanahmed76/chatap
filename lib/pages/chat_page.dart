import 'package:chatap/component/texrfiled.dart';
import 'package:chatap/services/auth/auth_services.dart';
import 'package:chatap/services/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiveEmail;
  final String receiverID;
  ChatPage({super.key, required this.receiveEmail, required this.receiverID});
//text contoller
  final TextEditingController _messageController = TextEditingController();

//chat and auth services
  final ChatServices _chatServices = ChatServices();
  final AuthServices _authService = AuthServices();

  //send message
  void sendMessage() async {
//if there is something insede the textfilled
    if (_messageController.text.isNotEmpty) {
      await _chatServices.sendMessage(receiverID, _messageController.text);
      //clear text contoller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiveEmail),
      ),
      body: Column(
        children: [
          //display all messages
          Expanded(child: _buildMessageList()),

          //user input
          _buildUserInput()
        ],
      ),
    );
  }

  //buildmeesagelist

  Widget _buildMessageList() {
    final currentUser = _authService.getCurrentUser();
    if (currentUser == null) {
      return const Center(child: Text("User not logged in"));
    }

    String senderID = currentUser.uid;

    return StreamBuilder(
        stream: _chatServices.getMessages(receiverID, senderID),
        builder: (context, snapshpt) {
          if (snapshpt.hasError) {
            return Text("Error");
          }
          if (snapshpt.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView(
              children: snapshpt.data!.docs
                  .map((doc) => _buildMessageItem(doc))
                  .toList());
        });
  }
  //build message item

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    //is current user

    bool isCureentUser = data['senderID'] == _authService.getCurrentUser()!.uid;
    var alignment =
        isCureentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(alignment: alignment, child: Text(data['message']));
  }
  //build messgage input

  Widget _buildUserInput() {
    return Row(
      children: [
        // textfilled should take up most of the space
        Expanded(
            child: MyTextfiled(
                hintext: "type any message",
                obscureText: false,
                controller: _messageController)),
        //send button
        IconButton(onPressed: sendMessage, icon: Icon(Icons.arrow_upward))
      ],
    );
  }
}
