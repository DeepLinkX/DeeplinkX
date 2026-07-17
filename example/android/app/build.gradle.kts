plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val demoKeystorePath = providers.environmentVariable("DEMO_KEYSTORE_PATH").orNull
val demoKeystorePassword = providers.environmentVariable("DEMO_KEYSTORE_PASSWORD").orNull
val demoKeyAlias = providers.environmentVariable("DEMO_KEY_ALIAS").orNull
val demoKeyPassword = providers.environmentVariable("DEMO_KEY_PASSWORD").orNull
val demoSigningValues =
    listOf(
        demoKeystorePath,
        demoKeystorePassword,
        demoKeyAlias,
        demoKeyPassword,
    )
val hasDemoSigning =
    demoSigningValues.all { !it.isNullOrBlank() }
require(demoSigningValues.none { !it.isNullOrBlank() } || hasDemoSigning) {
    "Demo signing requires DEMO_KEYSTORE_PATH, DEMO_KEYSTORE_PASSWORD, " +
        "DEMO_KEY_ALIAS, and DEMO_KEY_PASSWORD."
}

android {
    namespace = "io.github.deeplinkx.demo"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "io.github.deeplinkx.demo"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (hasDemoSigning) {
            create("demoRelease") {
                storeFile = file(requireNotNull(demoKeystorePath))
                storePassword = requireNotNull(demoKeystorePassword)
                keyAlias = requireNotNull(demoKeyAlias)
                keyPassword = requireNotNull(demoKeyPassword)
            }
        }
    }

    buildTypes {
        release {
            // Local release builds retain the Flutter template's debug signing.
            // CI supplies the dedicated demo signing configuration.
            signingConfig =
                if (hasDemoSigning) {
                    signingConfigs.getByName("demoRelease")
                } else {
                    signingConfigs.getByName("debug")
                }
        }
    }
}

flutter {
    source = "../.."
}
