import 'package:flutter_web/material.dart';
import 'package:unisinos_events/events/eventscreenpresenter.dart';

class EventScreen extends StatefulWidget {
  EventScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _EventScreenState createState() => new _EventScreenState();
}

class _EventScreenState extends State<EventScreen> implements EventScreenContract {
  EventScreenPresenter eventScreenPresenter;

  @override
  void initState() {
    super.initState();
    eventScreenPresenter = new EventScreenPresenter(this)
  }

  @override
  void screenUpdate() {
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hello, World!',
            ),
          ],
        ),
      ), 
    );
  }
}