import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ClikvarsityScreen extends StatefulWidget {
  @override
  _ClikvarsityScreenState createState() => _ClikvarsityScreenState();
}

class _ClikvarsityScreenState extends State<ClikvarsityScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Clikvarsity'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListView(
          children: <Widget>[
            InkWell(
              onTap: () {
                launch('http://clikvarsity.mybluemix.net',
                    enableJavaScript: true);
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('Clikvarsity Website'),
                ),
                elevation: 5,
              ),
            ),
            InkWell(
              onTap: () {
                launch('https://yourlearning.ibm.com/', enableJavaScript: true);
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('IBM Your Learning'),
                ),
                elevation: 5,
              ),
            ),
            InkWell(
              onTap: () =>
                  launch('https://sites.google.com/view/holticket/home'),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('HOLTicket Website'),
                ),
                elevation: 5,
              ),
            ),
            InkWell(
              onTap: () =>
                  launch('https://www.udemy.com/', enableJavaScript: true),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('Udemy Website'),
                ),
                elevation: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
