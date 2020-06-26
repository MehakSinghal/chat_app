import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
            stream: Firestore.instance
                .collection('chat')
                .orderBy(
              'createdAt',
              descending: true,
            )
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final chatDocs = chatSnapshot.data.documents;
              return ListView.builder(
                reverse: true,
                itemCount: chatDocs.length,
                itemBuilder: (ctx, index) => MessageBubble(
                  chatDocs[index]['text'],
                  chatDocs[index]['username'],
                  chatDocs[index]['userImage'],
                  chatDocs[index]['userId'] == futureSnapshot.data.uid,
                  key: ValueKey(chatDocs[index].documentID),
                ),
              );
            });
      },
    );
  }
}











//import '../widgets/message_bubble.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//
//class Messages extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return FutureBuilder(
//      future: FirebaseAuth.instance.currentUser(),
//      builder: (ctx, futureSnapshot) {
//        if (futureSnapshot.connectionState == ConnectionState.waiting) {
//          return Center(
//            child: CircularProgressIndicator(),
//          );
//        }
//        return StreamBuilder(
//            stream: Firestore.instance
//                .collection('chat')
//                .orderBy('createdAt', descending: true)
//                .snapshots(),
//            builder: (ctx, snapshot) {
//              if (snapshot.connectionState == ConnectionState.waiting) {
//                return Center(
//                  child: CircularProgressIndicator(),
//                );
//              }
//              return ListView.builder(
//                  reverse: true,
//                  itemCount: snapshot.data.documents.length,
//                  itemBuilder: (ctx, i) => MessageBubble(
//                        snapshot.data.documents[i]['text'],
//                        snapshot.data.documents[i]['userId'] ==
//                            futureSnapshot.data.uid,
//                      snapshot.data.documents[i]['username'],
//                    key: ValueKey(snapshot.data.documents[i].documentID),
//                      ));
//            });
//      },
//    );
//  }
//}
