import 'package:chatapp/src/domain/requests/bodys/post_create_group_body.dart';
import 'package:chatapp/src/domain/requests/bodys/post_send_message_body.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'messages_client.g.dart';

@RestApi()
abstract class MessagesClient {
  factory MessagesClient(Dio dio, {String baseUrl}) = _MessagesClient;

  @GET('/message/{groupId }')
  Future getMessages(@Path('groupId ') int groupId);

  @POST('/messages')
  Future sendMessage(@Body() PostSendMessageBody body);

  @GET('/Groups/{userId}')
  Future getGroups(@Path('userId') int userId);

  @POST('/CreateGroup')
  Future createGroup(@Body() PostCreateGroupBody body);

  @GET('/checkIfUserMessaged/{userAId}/{userBId}')
  Future checkIfUserMessaged(
      @Query('userAId') int userAId, @Query('userBId') int userBId);
}
