import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roomrai1/models/Transaction.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _checkListFav = [];
  List<Transaction> _data = [];
  List<Transaction> get data => _data;

  void toggleFavorite(Transaction word) {
    final number = _checkListFav.indexOf(word.showSearch);
    if (number == (-1)) {
      _data.add(word);
      _checkListFav.add(word.showSearch);
    } else {
      _data.remove(_data[number]);
      _checkListFav.remove(word.showSearch);
    }
    print("_checkList: ${_checkListFav.length}");
    print("_words: ${_data.length}");

    // final isExist = _words.contains(word);
    // if (isExist) {
    //   _words.remove(word);
    // } else {
    //   _words.add(word);
    // }
    notifyListeners();
  }

  bool isExist(Transaction word) {
    final isExist;
    if (_checkListFav.indexOf(word.showSearch) == (-1)) {
      isExist = false;
    } else {
      isExist = true;
    }
    return isExist;
  }

  void clearFavorite() {
    _data = [];
    _checkListFav = [];
    notifyListeners();
  }

  static FavoriteProvider of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<FavoriteProvider>(
      context,
      listen: listen,
    );
  }
}
