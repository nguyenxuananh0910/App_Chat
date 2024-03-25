import 'package:chatapp/core/constants/auth_value_const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class SignalRService {
  final HubConnection connection = HubConnectionBuilder()
      .withUrl('${AuthValueConst.baseApiUrl}/message-hub',
          options: HttpConnectionOptions(accessTokenFactory: () async {
        final prefs = await SharedPreferences.getInstance();
        // print(prefs.getString(AuthValueConst.token) ?? '');
        return prefs.getString(AuthValueConst.token) ?? '';
      }))
      .withAutomaticReconnect()
      .build();

  Future<void> connect() async {
    await connection.start()?.then((_) {
      print("Connection started");
    }).catchError((err) => print("Failed to connect: $err"));
  }

  // Future<void> setUserOnline(int userId) async {
  //   await connection.invoke("UpdateUserStatus", args: [userId, true]);
  // }
  //
  // Future<void> setUserOffline(int userId) async {
  //   await connection.invoke("UpdateUserStatus", args: [userId, false]);
  // }

  Future<void> disconnect() async {
    // await setUserOffline(Get.find<CheckLoginController>().userid.value);
    await connection.stop();

  }
}
