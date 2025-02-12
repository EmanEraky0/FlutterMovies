import 'package:flutter_test2/core/utils/general_response.dart';

import '../../data/repositories/auth_repo_impl.dart';
import '../entities/all_movies.dart';
import '../entities/item.dart';

class GetItemsUseCase {

  final AuthRepoImpl authRepo;

  GetItemsUseCase({required this.authRepo});



  Future<ApiResult> call() async {
    final items = await authRepo.getItems();

    if(items.hasData){
        items.data = Item( id: 1, description: items.data['status'], name: 'name');
        return items;
    }else{
      return items;
    }

  }


  Future<ApiResult> popularMovies(int page) async{
    final item = await authRepo.getPopularMovies(page);
    return item;
  }

}