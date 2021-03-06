// #docplaster
import 'dart:async';
import 'dart:io';

int stopAfter = 10;
// #docregion
Future main() async {
  var requests = await HttpServer.bind('localhost', 8888);
  // #enddocregion
  requests = requests.take(stopAfter);
  // #docregion
  await for (var request in requests) {
    processRequest(request);
  }
}

void processRequest(HttpRequest request) {
  print('Got request for ${request.uri.path}');
  final response = request.response;
  if (request.uri.path == '/dart') {
    response
      ..headers.contentType = new ContentType(
        'text',
        'plain',
      )
      ..write('Hello from the server');
  } else {
    response.statusCode = HttpStatus.NOT_FOUND;
  }
  response.close();
}
