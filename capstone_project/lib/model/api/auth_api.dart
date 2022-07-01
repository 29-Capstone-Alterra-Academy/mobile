import 'package:dio/dio.dart';
import '../users_data/auth_model.dart';

class API {
  static Future<List<Authentication>> postLogin() async {
    const authPort =
        'https://virtserver.swaggerhub.com/etrnal70/nomizo/1.0.0/login';

    final request = await Dio().post(authPort);

    List<Authentication> auth = (request.data as List)
        .map((e) => Authentication(email: e['email'], password: e['password']))
        .toList();

    return auth;
  }
}
