import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quinotes/services/auth.dart';
import 'package:quinotes/services/show_alert_dialog.dart';

import 'add_notes.dart';
import 'edit_note.dart';

class HomePage extends StatelessWidget {


  HomePage({Key key, @required this.auth, /*@required this.onSignOut*/}) : super(key: key);
  final AuthBase auth;
  final ref = FirebaseFirestore.instance.collection("notes");
  //final VoidCallback onSignOut;

  Future <void> _signOut() async{
    try {
      await auth.signOut();
      //onSignOut();
    } catch (e){
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async{
    final didRequestSignOut = await showAlertDialog(
        context,
        title: 'Logout',
        content: 'Are you sure you want to logout?',
        cancelActionText: 'Cancel',
        defaultActionText: 'Logout',
    );
    if (didRequestSignOut == true){
      _signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("notes"),
        actions: <Widget>[
          FlatButton(
            onPressed: _signOut,
            child: Text(
                "Logout",
                style: TextStyle(fontSize: 18.0, color: Colors.white)),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_)=>AddNote()));
        },
      ),
      body: StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return /*GridView.builder*/ListView.builder(
              /*gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),*/
                itemCount: snapshot.hasData ? snapshot.data.docs.length : 0,
                itemBuilder: (context, index) {
                  Map data = snapshot.data.docs[index].data();
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>EditNote(data: data,docToEdit:snapshot.data.docs[index],)));
                    },
                    child: /*Container*/ Card(
                      /*margin: EdgeInsets.all(10),
                        height: 150,
                        color: Colors.grey[200],*/
                      child: Padding(
                        padding: const EdgeInsets.only(left:20),
                        child: Column(
                          children: [
                            //Text(snapshot.data.docs[index].data()),
                            Container(
                              child: Text(
                                "${data['title']}",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: "Times",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(40, 3, 0, 5),
                              child: Text(
                                "${data['content']}",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: "lato",
                                  color: Colors.black54,
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            //Text("${data['content']}"),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            );
          }
      ),

    );
  }
}
