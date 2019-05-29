class Event {
  int id;
  String title;
  String description;
  String date;

  Event({this.title, this.description, this.date});

  Event.map(dynamic obj) {
    this.title = obj["title"];
    this.description = obj["description"];
    this.date = obj["date"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["firstname"] = title;
    map["description"] = description;
    map["date"] = date;
    return map;
  }
  void setEventId(int id) {
    this.id = id;
  }
}