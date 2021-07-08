
import 'package:qfvpn/s.dart';

class HttpErrorException{
  String? errorCode;
  String? errorMsg;

  HttpErrorException({this.errorCode, this.errorMsg});

  @override
  String toString() {
    return 'HttpErrorException: errorCode: ${errorCode?? 'null'}, errorMsg: ${errorMsg ?? 'null'}';
  }
}