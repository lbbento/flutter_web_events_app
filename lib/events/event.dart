class Event {
  String title;
  String description;
  String date;

  Event({this.title, this.description, this.date});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'],
      description: json['description'],
      date: json['date']
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'date': date
  };
}

class EventList {
  final List<Event> events;

  EventList({
    this.events
  });

  factory EventList.fromJson(List<dynamic> parsedJson) {

    List<Event> events = new List<Event>();
    events = parsedJson.map((i)=>Event.fromJson(i)).toList();

    return new EventList(
       events: events,
    );
  }
}