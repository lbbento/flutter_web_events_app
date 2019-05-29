import 'dart:async';

import 'package:unisinos_events/db/database_helper.dart';
import 'package:unisinos_events/events/event.dart';

abstract class EventScreenContract {
  void screenUpdate();
}

class EventScreenPresenter {
  EventScreenContract _view;
  var db = new DatabaseHelper();
  
  EventScreenPresenter(this._view);

  Future<List<Event>> getEvent() {
    return db.getEvent();
  }

  updateScreen() {
    _view.screenUpdate();

  }
}