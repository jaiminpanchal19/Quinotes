import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {

  DocumentSnapshot docToEdit;
  final Map data;
  EditNote({this.docToEdit,this.data});

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  void initState() {
    title = TextEditingController(text: "${widget.data['title']}");
    content = TextEditingController(text: "${widget.data['content']}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              FlatButton(
                  onPressed: () {
                    widget.docToEdit.reference.update({
                      'title': title.text,
                      'content':content.text,
                    }).whenComplete(() => Navigator.pop(context));
                  },
                  child: Text('save')),
              ElevatedButton(
                  onPressed: () {
                    widget.docToEdit.reference.delete().whenComplete(() => Navigator.pop(context));
                  },
                  child: Icon(
                    Icons.delete_forever,
                    size: 32.0,
                  ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
              )
            ]
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: title,
                  decoration: InputDecoration(hintText: 'Title'),
                ),
              ),
              SizedBox(height: 10,),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: TextField(
                    controller: content,
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(hintText: 'Content'),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
