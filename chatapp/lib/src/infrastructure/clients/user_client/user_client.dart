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
  Future loginUser({
    @Field('username') required String username,
    @Field('password') required String password,
  });

  @GET('/user/{userId}')
  Future getUser(@Path('userId') int userId);

  @GET('/users')
  Future getUsers(@Query('userId') int userId);
}
