import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class OtherModules {
  Dio initDio() {
    final dio = Dio(
      BaseOptions(
        headers: {'Content-Type': 'application/json'},
        followRedirects: true,
        sendTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 25),
        connectTimeout: const Duration(seconds: 20),
      ),
    );
    // init some interceptors here
    // dio.interceptors.add(AuthInterceptor(Constant.accessToken));
    // customization
    dio.interceptors.clear();
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
      ),
    );
    dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (request, handler) async {
          return handler.next(request);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) async {
          if (error.response != null) {
            // if (error.response!.statusCode == 401) {
            //   try {
            //     final dioClient = Dio();
            //     var accessToken = '';
            //     // final userName =
            //     //     Storage.instance.readString(Constant.userNameKey);
            //     final headers = {
            //       'Content-Type': 'application/x-www-form-urlencoded',
            //     };
            //
            //     final formData = {
            //       'grant_type': 'client_credentials',
            //       // 'client_id': userName,
            //       // 'client_secret': getSecretKeyByClientId(userName),
            //     };
            //     final tokenResponse = await dioClient.post(
            //       '${AppCore.coreUri.urlPhanAnh}/getToken',
            //       options: Options(headers: headers),
            //       data: formData.entries
            //           .map((e) => '${e.key}=${e.value}')
            //           .join('&'),
            //     );
            //
            //     if (tokenResponse.statusCode == 200) {
            //       accessToken = tokenResponse.data['access_token'].toString();
            //       // Handle the token response as needed
            //     } else {
            //       return handler.next(error);
            //     }
            //     final requestOptions = error.requestOptions;
            //     final opts = Options(method: requestOptions.method);
            //     dio.options.baseUrl = requestOptions.baseUrl;
            //     dio.interceptors.add(AuthInterceptor(accessToken));
            //     dio.options.headers['Accept'] = '*/*';
            //     final response = await dio.request(
            //       requestOptions.path,
            //       options: opts,
            //       cancelToken: requestOptions.cancelToken,
            //       onReceiveProgress: requestOptions.onReceiveProgress,
            //       data: requestOptions.data,
            //       queryParameters: requestOptions.queryParameters,
            //     );
            //     if (response.statusCode == 200) {
            //       return handler.resolve(response);
            //     }
            //   } catch (e) {
            //     return handler.next(error);
            //   }
            // }
          }
          return handler.next(error);
        },
      ),
    );
    return dio;
  }
}
