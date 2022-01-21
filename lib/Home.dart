import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/SignIn.dart';
import 'package:provider/provider.dart';
import 'authentication.dart';
import 'database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/AddView.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home'), actions: <Widget>[
        ElevatedButton.icon(
          icon: Icon(Icons.person),
          onPressed: () async {
            await context.read<AuthenticationService>().signOut();
          },
          label: Text('Sign Out'),
        )
      ]),
      body: Container(
        child: Center(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('Items')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView(
                  children: snapshot.data!.docs.map((document) {
                    return Container(
                        child: Row(
                      children: [
                        Text("Item: ${document.id} \t"),
                        Text("Price: ${document['Amount']}"),
                      ],
                    ));
                  }).toList(),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddView()),
          );
        },
      ),
    );
  }
}
