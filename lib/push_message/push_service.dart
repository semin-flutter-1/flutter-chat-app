import 'package:chat_app/model/result.dart';
import 'package:http/http.dart' as http;

// 싱글턴
class PushService {
  static final PushService _pushService = PushService._internal();

  factory PushService() {
    return _pushService;
  }

  PushService._internal();

  Future<Result> sendPush(String title, String body) async {
    try {
      var url = Uri.parse(
          'https://us-central1-fir-test-b1efc.cloudfunctions.net/sendFcm');
      var response = await http.post(
        url,
        body: {'title': '$title', 'body': '$body'},
      );

      return Result.success(response);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }
}
