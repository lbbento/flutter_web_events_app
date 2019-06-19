import 'dart:async';
import 'package:flutter_web/material.dart';
import 'package:unisinos_events/events/data/eventapi.dart';
import 'package:unisinos_events/events/event.dart';

class EventAddDialog extends StatelessWidget {
  
  final teTitle = TextEditingController();
  final teDescription = TextEditingController();
  final teDate = TextEditingController();

  static const TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  @override
  Widget build(BuildContext context) {

    return new AlertDialog(
      title: new Text('Adicionar novo evento'),
      content: new SingleChildScrollView(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTextField("Entre o titulo", teTitle),
            getTextField("Entre a descricao", teDescription),
            getTextField("DD/MM/YYYY", teDate),
            new GestureDetector(
              onTap: () async {
                if (await addRecord(new Event(title: teTitle.text, description: teDescription.text, date: teDate.text))) {
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

  Future<bool> addRecord(Event event) async {
    EventApi eventApi = EventApi();

    return eventApi.putEvent(event);
  }
}