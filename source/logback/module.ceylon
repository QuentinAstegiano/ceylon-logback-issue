"Default documentation for module `logback`."
native ("jvm")
module logback "1.0.0" {
    import maven : "org.slf4j:slf4j-api" "1.7.22";
    import maven : "ch.qos.logback:logback-classic" "1.1.7";
    import maven : "ch.qos.logback:logback-core" "1.1.7";
}
