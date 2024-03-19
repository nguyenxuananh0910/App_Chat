import 'package:chatapp/src/domain/requests/bodys/post_login_body.dart';
import 'package:chatapp/src/domain/requests/bodys/post_sign_body.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'user_client.g.dart';

@RestApi()
abstract class UserClient {
  factory UserClient(Dio dio, {String baseUrl}) = _UserClient;

  @POST('/sign')
  Future signUser(@Body() PostSignBody body);

  @POST('/login')
  Future loginUser(@Body() PostLoginBody body);

  @GET('/user/{userId}')
  Future getUser(@Path('userId') int userId);

  @GET('/users')
  Future getUsers(@Query('userId') int userId);

  @PATCH('/updateStatusUser/{userId}/{status}')
  Future updateUserStatus(
      @Path('userId') int userId, @Path('status') bool status);
}
