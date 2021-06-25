plugins {
    kotlin("jvm") version "1.5.10"
    `java-gradle-plugin`
}

repositories {
    mavenCentral()
    google()
}

dependencies {
    implementation(kotlin("gradle-plugin"))
    implementation(kotlin("serialization"))
    implementation("com.android.tools.build:gradle:4.2.1")
    implementation("com.google.devtools.ksp:symbol-processing-gradle-plugin:1.5.10-1.0.0-beta01")
}

gradlePlugin {
    plugins {
        create("golang") {
            id = "clash-build"
            implementationClass = "com.github.kr328.clash.tools.ClashBuildPlugin"
        }
    }
}
