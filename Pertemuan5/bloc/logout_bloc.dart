
import '../helpers/user_info.dart';

class LogoutBloc {
  Future<void> logout() async {
    await UserInfo().logout();
  }
}
