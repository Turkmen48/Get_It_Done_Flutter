import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getitdone/models/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemsData with ChangeNotifier {
  static SharedPreferences? _sharedPref;
  List<String> _itemsAsString = [];

  final List<Item> _items = [
    //Item(title: "Peynir Al"),
    // Item(title: "Ekmek Al"),
    // Item(title: "Çöpü At"),
    // Item(title: "Flutter Çalış")
  ];
  void toggleStatus(int index) {
    _items[index].toggleStatus();
    saveItemToSharedPrefs(_items);
    notifyListeners();
  }

  void addItem(String title) {
    _items.add(Item(title: title));
    saveItemToSharedPrefs(_items);
    notifyListeners();
  }

  void deleteItem(int index) {
    _items.removeAt(index);
    saveItemToSharedPrefs(_items);
    notifyListeners();
  }

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  ///shared pref methods///
  Future<void> createPrefObject() async {
    _sharedPref = await SharedPreferences.getInstance();
  }

  void saveItemToSharedPrefs(List<Item> items) {
    ///List<Item>  --> List<String>
    _itemsAsString.clear();
    for (var item in _items) {
      _itemsAsString.add(jsonEncode(item.toMap()));
    }
    _sharedPref?.setStringList('toDoData', _itemsAsString);
  }

  void loadItemsFromSharedPref() {
    List? tempList = _sharedPref?.getStringList('toDoData') ?? [];
    _items.clear();
    for (var item in tempList) {
      _items.add(Item.fromMap(jsonDecode(item)));
    }
  }
}
