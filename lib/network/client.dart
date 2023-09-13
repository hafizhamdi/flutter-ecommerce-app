import 'package:http/http.dart' as http;

class NetworkClient {
  final String? baseUrl;

  NetworkClient({this.baseUrl});

  Future<http.Response> get({endpoint}) async {
    var url = "$baseUrl$endpoint";
    var response = await http.get(Uri.parse(url));
    return response;
  }

  Future<http.Response> post({endpoint, body}) async {
    var url = "$baseUrl$endpoint";
    var response = await http.post(Uri.parse(url), body: body);
    return response;
  }
}
