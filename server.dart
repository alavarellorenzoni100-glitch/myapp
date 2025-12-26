import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

Future<void> main(List<String> args) async {
  final router = Router();

  // API endpoint semplice
  router.get('/api/hello', (Request req) {
    final payload = {'message': 'Ciao dal server Dart!', 'time': DateTime.now().toIso8601String()};
    return Response.ok(jsonEncode(payload), headers: {'content-type': 'application/json; charset=utf-8'});
  });

  // Se vuoi aggiungere altre API:
  router.get('/api/echo/<text>', (Request req, String text) {
    return Response.ok(jsonEncode({'echo': text}), headers: {'content-type': 'application/json; charset=utf-8'});
  });

  // Serve file statici dalla cartella "web"
  final staticHandler = createStaticHandler('web', defaultDocument: 'index.html', listDirectories: false);

  // Cascade: prima le API, poi i file statici
  final handler = Cascade().add(router.handler).add(staticHandler).handler;

  // Aggiungi logging
  final pipeline = const Pipeline().addMiddleware(logRequests()).addHandler(handler);

  // Start server su loopback: porta 8080
  final server = await io.serve(pipeline, InternetAddress.loopbackIPv4, 8080);
  print('Server avviato: http://${server.address.host}:${server.port}');
}
