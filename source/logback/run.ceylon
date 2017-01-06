import org.slf4j {
    LoggerFactory
}
import ch.qos.logback.classic {
    LoggerContext
}

shared void run() {
    value iLoggerFactory = LoggerFactory.iLoggerFactory;

    if (is LoggerContext iLoggerFactory) {
        LoggerContext ctx = iLoggerFactory;
        ctx.getLogger("logback" of String).info("Logging with logback");
    } else {
        print("LoggerFactory is not an instance of LoggerContext: " + iLoggerFactory.string);
    }
}
