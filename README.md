This repository is a simple example of an issue I have. 

There's a conflict with Ceylon, SLF4J, and Logback.

From what I can tell, Ceylon load with it's SDK the library "slf4j-simple". It means that you can't use Logback as your SL4FJ implementation: the SLF4J binder coming with Logback will be loaded after the one provided by SLF4J-Simple (as that jar is loaded before the module, with the Ceylon runtime).

## Module description

```
module logback "1.0.0" {
    import maven : "ch.qos.logback:logback-classic" "1.1.7";
    import maven : "ch.qos.logback:logback-core" "1.1.7";
}
```

A simplified use case: I only want to use slf4j-api and logback.
I don't even have to import slf4j-api, as it is already included in the classpath. Including a different version of slf4j-api (for example, 1.7.22) does not change the issue.

## Test code

```
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
``` 

``LoggerContext`` is the Logback implementation.
When the module is run, I get the following output:
```
LoggerFactory is not an instance of LoggerContext: org.slf4j.impl.SimpleLoggerFactory@f09733f
```

## Why is this an issue ?

Because some library are very opinionated on their SLF4J implementation choice, and you can't make them work with another implementation (for example: Dropwizard, see https://github.com/dropwizard/dropwizard/issues/1367 ).

