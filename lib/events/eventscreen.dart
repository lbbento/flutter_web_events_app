import 'package:flutter_web/material.dart';
import 'package:unisinos_events/events/add/eventadddialog.dart';
import 'package:unisinos_events/events/event.dart';
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
    eventScreenPresenter = new EventScreenPresenter(this);
  }

  @override
  void screenUpdate() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
      future: eventScreenPresenter.getEvent(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new Text('loading...');
          default:
            if (snapshot.hasError) {
              return new Text('Error: ${snapshot.error}');
            } else {
              return createListView(context, snapshot);
            } 
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Eventos"),
      ),
      body: futureBuilder,
      floatingActionButton: FloatingActionButton(
        onPressed: addEvent,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Event> events = snapshot.data;
    return new ListView.builder(
        itemCount: events.length,
        itemBuilder: (BuildContext context, int index) {
          return new Column(
            children: <Widget>[
              new ListTile(
                title: new Text(events[index].title),
              ),
              new Divider(height: 2.0,),
            ],
          );
        },
    );
  }

  void addEvent() {

    showDialog(
      context: context,
      builder: (BuildContext context) => EventAddDialog()
    );

  }
}