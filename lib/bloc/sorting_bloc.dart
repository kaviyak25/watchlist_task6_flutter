import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Api/base_client.dart';
import '../Api/contacts_model.dart';

class SortingEvent {}

class AscendingSortEvent extends SortingEvent {}

class DescendingSortEvent extends SortingEvent {}

class OriginalDataEvent extends SortingEvent {}

class SortingState {
  final List<Contacts> contacts;
  final bool ascendingOrder;

  SortingState(this.contacts, this.ascendingOrder);
}

class SortingBloc extends Bloc<SortingEvent, SortingState> {
  SortingBloc() : super(SortingState([], true)) {
    on<AscendingSortEvent>((event, emit) async {
      try {
        final sortedData = await fetchDataAndSort(true);
        emit(sortedData);
      } catch (error) {}
    });

    on<DescendingSortEvent>((event, emit) async {
      try {
        final sortedData = await fetchDataAndSort(false);
        emit(sortedData);
      } catch (error) {}
    });

    on<OriginalDataEvent>((event, emit) async {
      try {
        final originalData = await fetchOriginalData();
        emit(originalData);
      } catch (error) {}
    });
  }

  Future<SortingState> fetchDataAndSort(bool ascendingOrder) async {
    final response = await BaseClient().get('msf/getContacts');

    if (response is String) {
      final List<Contacts> contacts = contactsFromJson(response);

      if (ascendingOrder) {
        contacts.sort((a, b) {
          final aId = int.parse(a.id);
          final bId = int.parse(b.id);
          return aId.compareTo(bId);
        });
      } else {
        contacts.sort((a, b) {
          final aId = int.parse(a.id);
          final bId = int.parse(b.id);
          return bId.compareTo(aId);
        });
      }

      return SortingState(contacts, true);
    } else {
      throw Exception('Error occurred');
    }
  }

  Future<SortingState> fetchOriginalData() async {
    final response = await BaseClient().get('msf/getContacts');

    if (response is String) {
      final List<Contacts> contacts = contactsFromJson(response);
      return SortingState(contacts, true);
    } else {
      throw Exception('Error occurred');
    }
  }
}
