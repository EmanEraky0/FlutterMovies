import 'package:flutter_test2/data/repositories/auth_repo.dart';
import 'package:flutter_test2/data/services/auth_service.dart';
import '../../core/utils/general_response.dart';

class AuthRepoImpl extends AuthRepo{
  final AuthService authService;

  AuthRepoImpl({required this.authService});

  @override
  Future<ApiResult > getItems() async {
    return await authService.fetchData();
  }

  @override
  Future<ApiResult> getPopularMovies(int page) async{
    return await authService.getPopularMovies(page: page);
  }

  @override
  Future<ApiResult> login(String email, String password) async{
    return await authService.login(email, password);

  }
}