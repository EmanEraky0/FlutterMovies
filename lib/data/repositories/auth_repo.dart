import '../../core/utils/general_response.dart';

abstract class AuthRepo{
  Future<ApiResult> getItems();
  Future<ApiResult> login(String email , String password);
  Future<ApiResult> getPopularMovies(int page);
}