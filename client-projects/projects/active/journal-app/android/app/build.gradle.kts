plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.vivacitydigital.journal_app"
    compileSdk = 34

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.vivacitydigital.journal_app"
        minSdk = 21  // Android 5.0 (Lollipop) minimum
        targetSdk = 34  // Android 14
        versionCode = 1
        versionName = "1.0.0"
        multiDexEnabled = true

        // Enable R8 full mode for better optimization
        buildConfigField("String", "BUILD_TIME", "\"${new Date().format('yyyy-MM-dd HH:mm:ss')}\"")
    }

    signingConfigs {
        release {
            if (keystorePropertiesFile.exists()) {
                keyAlias = keystoreProperties['keyAlias']
                keyPassword = keystoreProperties['keyPassword']
                storeFile = keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
                storePassword = keystoreProperties['storePassword']
            }
        }
    }

    buildTypes {
        release {
            // Enable ProGuard/R8 shrinking and obfuscation
            minifyEnabled = true
            shrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )

            // Use release signing config if keystore exists, otherwise use debug
            signingConfig = keystorePropertiesFile.exists() ?
                signingConfigs.getByName("release") :
                signingConfigs.getByName("debug")

            ndk {
                // Specify ABIs to include (reduces APK size)
                abiFilters 'armeabi-v7a', 'arm64-v8a', 'x86_64'
            }
        }

        debug {
            applicationIdSuffix = ".debug"
            versionNameSuffix = "-debug"
            debuggable = true
        }
    }

    packagingOptions {
        resources {
            excludes += ['/META-INF/{AL2.0,LGPL2.1}']
        }
    }

    bundle {
        language {
            // Enable language splits for smaller app bundles
            enableSplit = true
        }
        density {
            // Enable density splits
            enableSplit = true
        }
        abi {
            // Enable ABI splits
            enableSplit = true
        }
    }
}

flutter {
    source = "../.."
}
