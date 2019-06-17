import 'dart:async';
import 'package:flutter_web/material.dart';
import 'package:unisinos_events/events/data/eventapi.dart';
import 'package:unisinos_events/events/event.dart';

class EventAddDialog {
  
  final teTitle = TextEditingController();
  final teDescription = TextEditingController();
  final teDate = TextEditingController();
  Event event;

  static const TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  Widget buildAboutDialog(
      BuildContext context, _myEventPageState, Event event) {
    if (event != null) {
      this.event=event;
      teTitle.text = event.title;
      teDescription.text = event.description;
      teDate.text = event.date;
    }

    return new AlertDialog(
      title: new Text('Add new Event'),
      content: new SingleChildScrollView(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTextField("Enter title", teTitle),
            getTextField("Enter descriptiom", teDescription),
            getTextField("DD-MM-YYYY", teDate),
            new GestureDetector(
              onTap: () async {
                if (await addRecord()) {
                  _myEventPageState.displayRecord();
                  Navigator.of(context).pop();
                }
              },
              child: new Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: getAppBorderButton(
                    "Add", EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTextField(
      String inputBoxName, TextEditingController inputBoxController) {
    var loginBtn = new Padding(
      padding: const EdgeInsets.all(5.0),
      child: new TextFormField(
        controller: inputBoxController,
        decoration: new InputDecoration(
          hintText: inputBoxName,
        ),
      ),
    );

    return loginBtn;
  }

  Widget getAppBorderButton(String buttonLabel, EdgeInsets margin) {
    var loginBtn = new Container(
      margin: margin,
      padding: EdgeInsets.all(8.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        border: Border.all(color: const Color(0xFF28324E)),
        borderRadius: new BorderRadius.all(const Radius.circular(6.0)),
      ),
      child: new Text(
        buttonLabel,
        style: new TextStyle(
          color: const Color(0xFF28324E),
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
    );
    return loginBtn;
  }

  Future<bool> addRecord() async {
    EventApi eventApi = EventApi();

    return eventApi.putEvent(event);
  }
}