
import '../helpers/api.dart';
import '../helpers/api_url.dart';

class RegistrasiBloc {
  Future<dynamic> registrasi(Map<String, dynamic> data) async {
    return await Api().post(ApiUrl.registrasi, data);
  }
}
