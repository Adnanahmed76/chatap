import 'package:chatap/component/user_tile.dart';
import 'package:chatap/services/auth/auth_services.dart';
import 'package:chatap/component/my_drawer.dart';
import 'package:chatap/services/chat/chat_services.dart';
import 'package:flutter/material.dart';

import 'chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//chat and auth services

  final ChatServices _chatServices = ChatServices();
  final AuthServices _authServices = AuthServices();

  void logout() {
    //get auth services
    final _auth = AuthServices();
    _auth.signOut();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
        actions: [
          IconButton(onPressed: logout, icon: Icon(Icons.logout_outlined))
        ],
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  //build a list of users except for the currect logged in
  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatServices.getUsersStream(),
        builder: (context, snapshot) {
          //erroe
          if (snapshot.hasError) {
            return Text("Error");
          }
          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("loading");
          }
          //return list view
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }
}

Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
  return UserTile(
    onTap: () {
//tapped on a user-> go to chat app
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatPage(
                    receiveEmail: userData['email'],
                    receiverID: userData['uid'],
                  )));
    },
    text: userData["email"] ?? "no Email",
  );
}
