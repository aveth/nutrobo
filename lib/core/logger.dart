import 'package:logging/logging.dart';

void log(String message) {
  Logger.root.log(Level.FINE, message);
}