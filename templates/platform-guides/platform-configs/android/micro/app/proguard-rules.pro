# Flutter ProGuard Rules for Journal App

# Keep Flutter Engine
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Keep Kotlin Metadata
-keep class kotlin.Metadata { *; }
-keepattributes *Annotation*

# Keep R8 from removing native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep serialization classes
-keepnames class * implements java.io.Serializable
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    !static !transient <fields>;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# Keep SQLite classes
-keep class org.sqlite.** { *; }
-keep class org.sqlite.database.** { *; }

# Keep Sqflite
-keep class com.tekartik.sqflite.** { *; }

# Keep SharedPreferences
-keep class android.content.SharedPreferences { *; }
-keep class android.content.SharedPreferences$** { *; }

# Keep Path Provider
-keep class io.flutter.plugins.pathprovider.** { *; }

# Keep Local Notifications
-keep class com.dexterous.** { *; }
-keep class com.dexterous.flutterlocalnotifications.** { *; }

# Keep Share Plus
-keep class dev.fluttercommunity.plus.share.** { *; }

# Keep PDF/Printing
-keep class net.sf.andpdf.** { *; }
-keep class printing.flutter.io.** { *; }

# Keep Permission Handler
-keep class com.baseflow.permissionhandler.** { *; }

# Gson (if used for JSON parsing)
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn sun.misc.**
-keep class com.google.gson.** { *; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Keep Crashlytics (if added in future)
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception

# Remove logging in release
-assumenosideeffects class android.util.Log {
    public static boolean isLoggable(java.lang.String, int);
    public static int v(...);
    public static int i(...);
    public static int w(...);
    public static int d(...);
    public static int e(...);
}

# Don't warn about missing classes
-dontwarn javax.annotation.**
-dontwarn org.conscrypt.**
-dontwarn org.bouncycastle.**
-dontwarn org.openjsse.**

# Optimization
-optimizationpasses 5
-dontusemixedcaseclassnames
-verbose
