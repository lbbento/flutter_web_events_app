import 'dart:async';

import 'package:unisinos_events/events/data/eventapi.dart';
import 'package:unisinos_events/events/event.dart';

abstract class EventScreenContract {
  void screenUpdate();
}

class EventScreenPresenter {
  EventScreenContract _view;
  EventApi _eventapi = new EventApi();
  
  EventScreenPresenter(this._view);

  Future<List<Event>> getEvent() {
    return _eventapi.getEvent();
  }

  updateScreen() {
    _view.screenUpdate();
  }
}