import 'package:flutter_test2/data/repositories/auth_repo_impl.dart';
import 'package:flutter_test2/data/services/api_service.dart';
import 'package:flutter_test2/data/services/auth_service.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setUpLocator() {
locator.registerLazySingleton(()=>ApiServices(baseUrl: 'https://api.themoviedb.org/3/movie/'));
locator.registerLazySingleton(()=>AuthService(apiServices: locator<ApiServices>()));
locator.registerLazySingleton(()=> AuthRepoImpl(authService:locator<AuthService>()));

}


