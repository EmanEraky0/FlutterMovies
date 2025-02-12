import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test2/domain/entities/all_movies.dart';
import '../../domain/entities/item.dart';
import '../../domain/usecases/get_itemsUseCase.dart';
import '../../core/utils/state_screen.dart';

class ItemViewModel with ChangeNotifier {
  final GetItemsUseCase getItemsUseCase;

  int page = 1;
  bool loadingMore=false;
  ItemViewModel({required this.getItemsUseCase});

  List<Item> items = [];
  var errorMsg = '';
  StateScreen state = StateScreen.init;

  AllMovies allMovies =AllMovies(results: []) ;

  fetchItems() async {
    state = StateScreen.loading;
    final res = await getItemsUseCase.call();
    if (res.hasData) {
      try {
        state = StateScreen.loaded;
        items.add(res.data);
      } catch (ex) {
        errorMsg = ex.toString();
        state = StateScreen.error;
      }
    } else {
      errorMsg = '${res.failure!.message} ${res.failure!.code}';
      state = StateScreen.error;
    }
    notifyListeners();
  }

  callPopularMovies() async {
    state = StateScreen.loading;
    loadingMore = true;
    final result =  await getItemsUseCase.popularMovies(page);
    if(result.hasData && loadingMore ){
      page++;
      state =StateScreen.loaded;
      allMovies.results.addAll( AllMovies.fromJson(result.data).results);
    }else {
      errorMsg = '${result.failure!.message} ${result.failure!.code}';
      state = StateScreen.error;
      loadingMore = false;
    }
    notifyListeners();
  }

}
