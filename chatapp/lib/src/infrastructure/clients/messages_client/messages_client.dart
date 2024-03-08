import 'package:chatapp/src/domain/requests/bodys/post_create_group_body.dart';
import 'package:chatapp/src/domain/requests/bodys/post_send_message_body.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'messages_client.g.dart';

@RestApi()
abstract class MessagesClient {
  factory MessagesClient(Dio dio, {String baseUrl}) = _MessagesClient;

  @GET('/Messages/{groupId}')
  Future getMessages(@Path('groupId') int groupId);

  @POST('/Message')
  Future sendMessage(@Body() PostSendMessageBody body);

  @GET('/Groups/{userId}')
  Future getGroups(@Path('userId') int userId);

  @POST('/CreateGroup')
  Future createGroup(@Body() PostCreateGroupBody body);

  @GET('/CheckIfUsersMessaged/{userAId}/{userBId}')
  Future checkIfUserMessaged(
      @Path('userAId') int userAId, @Path('userBId') int userBId);
}
