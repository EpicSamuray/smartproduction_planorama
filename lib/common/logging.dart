import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:stack_trace/stack_trace.dart';

class CustomPrinter extends LogPrinter {
  final String className;

  CustomPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    var color = PrettyPrinter.defaultLevelColors[event.level];
    var emoji = PrettyPrinter.defaultLevelEmojis[event.level];
    var message = event.message;
    var time = DateTime.now();

    // Getting the stack trace and omitting the first few frames which belong to the Logger and CustomPrinter
    var trace = Trace.current(4);
    var frame = trace.frames.firstWhere(
            (f) => !f.library.contains('logger.dart') && !f.library.contains('custom_printer.dart') && f.member != null,
        orElse: () => Frame(Uri.parse('package:unknown'), 0, 0, 'unknown method')
    );

    var methodName = frame.member!;

    return [
      color!('$emoji [$time] $className | $methodName - $message')
    ];
  }
}

class Logging {
  final String className;
  late final Logger _logger;

  Logging(this.className) {
    _logger = Logger(
      printer: CustomPrinter(className),
    );
  }

  void logInfo(String message) {
    _logger.i(message);
  }

  void logWarning(String message) {
    _logger.w(message);
  }

  void logError(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  void logDebug(String message) {
    _logger.d(message);
  }
}

class L {
  static void log(dynamic msg) {
    final Logger logger = Logger();
    logger.log(Level.debug, msg);
  }
}

class ProvidersLogger extends ProviderObserver {
  @override
  void didAddProvider(
      ProviderBase provider,
      Object? value,
      ProviderContainer container,
      ) {
    //super.didAddProvider(provider, value, container);

    L.log('''
    {
      "provider": "${provider.name ?? provider.runtimeType}",
      "value": "$value",
      "container: "$container"
    }''');
  }

  @override
  void didUpdateProvider(
      ProviderBase provider,
      Object? previousValue,
      Object? newValue,
      ProviderContainer container,
      ) {
    L.log('''
    {
      "provider": "${provider.name ?? provider.runtimeType}",
      "newValue": "$newValue"
    }''');
  }

  @override
  void didDisposeProvider(
      ProviderBase provider,
      ProviderContainer container,
      ) {
    //super.didDisposeProvider(provider, containers);

    L.log('''
    {
      "provider": "${provider.name ?? provider.runtimeType}",
      "containers": "$container"
    }''');
  }
}
