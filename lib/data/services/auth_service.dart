import 'package:flutter_test2/data/services/api_service.dart';
import 'package:flutter_test2/data/services/end_point.dart';
import 'package:flutter_test2/core/utils/general_response.dart';

class AuthService {
  final ApiServices apiServices;

  AuthService({required this.apiServices});

  Future<ApiResult> login(String email, String password) async {
    final body = {'email': email, 'password': password};
  return  await apiServices.post(ApiEndPoints.login,
        headers: {'Content-Type': 'application/json'}, body: body);
  }

  Future<ApiResult> fetchData() async {
    return  await apiServices.get(ApiEndPoints.fetchData,
        headers: {'Content-Type': 'application/json'});
  }

  Future<ApiResult> getPopularMovies({required int page}) async{
    return await apiServices.get(ApiEndPoints.popularMovies ,queryParameters:{'page': page.toString()} );
  }

}
