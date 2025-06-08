import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String receiverID;
  final String message;
  final Timestamp timestamp;
  Message(
      {required this.message,
      required this.receiverID,
      required this.senderEmail,
      required this.senderId,
      required this.timestamp});

  //convert to a map
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': receiverID,
      'receiverId': receiverID,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
