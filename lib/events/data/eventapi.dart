import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:unisinos_events/events/event.dart';

class EventApi {

  Future<List<Event>> getEvent() async {
    final response = await http.get('https://jsonplaceholder.typicode.com/event');

    if (response.statusCode == 200) {
      final jsonContent = json.decode(response.body);
      return EventList.fromJson(jsonContent).events;
    } else {
      throw Exception('Erro ao carregar eventos');
    }
  }

   Future<bool> putEvent(Event event) async {
    final response = await http.put('https://jsonplaceholder.typicode.com/event', 
                    headers: { 'Content-Type':'application/json' }, 
                    body: event.toJson());

    return response.statusCode == 200;
  }
}