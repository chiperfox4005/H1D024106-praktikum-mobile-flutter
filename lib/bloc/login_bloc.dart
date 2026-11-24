
import '../helpers/api.dart';
import '../helpers/api_url.dart';
import '../helpers/user_info.dart';

class LoginBloc {
  final UserInfo userInfo = UserInfo();

  Future<dynamic> login(Map<String, dynamic> data) async {
    final response = await Api().post(ApiUrl.login, data);

    if (response is Map && response['data'] is Map) {
      final result = response['data'];
      if (result['token'] != null) {
        await userInfo.setToken(result['token'].toString());
      }
    } else if (response is Map && response['token'] != null) {
      await userInfo.setToken(response['token'].toString());
    }

    return response;
  }
}
