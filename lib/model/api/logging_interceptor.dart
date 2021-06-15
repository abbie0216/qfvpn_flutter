import 'package:http_interceptor/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print('[HttpLog] ${data.toString()}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print('[HttpLog] ${data.method}, ${data.url}, ${data.statusCode}');
    print('[HttpLog] headers:${data.headers}');
    print('[HttpLog] body:${data.body}');

    return data;
  }
}