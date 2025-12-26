# my-app (Dart server + JS frontend)

Questo progetto mostra come creare un server locale in Dart (senza Flutter) che:
- Serve file statici (HTML/JS) dalla cartella `web`
- Espone una piccola API JSON (`/api/hello`)

Requisiti
- Dart SDK installato: https://dart.dev/get-dart

Esecuzione
1. Nella root del progetto:
   ```bash
   dart pub get
   dart run bin/server.dart
   ```
2. Apri il browser su: http://localhost:8080

Struttura suggerita
- pubspec.yaml
- bin/server.dart
- web/index.html
- web/main.js

Note
- Puoi aggiungere altre rotte con `shelf_router` o usare WebSocket se ti servono connessioni in tempo reale.
- Questo esempio usa `createStaticHandler` per servire il frontend e `shelf_router` per le API.
