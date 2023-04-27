export './private/localstorage.dart'
  if (dart.library.html) './private/web_localstorage.dart'
  if (dart.library.io) './private/io_localstorage.dart' show LocalStorage;