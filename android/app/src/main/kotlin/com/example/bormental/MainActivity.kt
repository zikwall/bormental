package com.example.bormental

import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import android.text.TextUtils
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.lang.ref.WeakReference
import java.util.*

class MainActivity: FlutterActivity() {
    private val CHANNEL = "flutter.native/helper";

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val context: Context = getApplicationContext()
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            // Note: this method is invoked on the main thread.
            call, result ->
            if (call.method == "installedFromMarket") {
                val status = installedFromMarket(WeakReference(context));
                result.success(status)
            } else if (call.method == "isInstalledOneOfPackages") {
                val packages = call.argument<List<String>>("packages");
                var status = false;

                for (pack in packages.orEmpty()) {
                    if (isPackageInstalled(pack, context.packageManager)) {
                        status = true;
                        break;
                    }
                }
                result.success(status);
            } else {
                result.notImplemented()
            }
        }
    }

    private val INSTALLER_ADB = "adb"
    private val INSTALLER_PACKAGE_INSTALLER_NOUGAT = "com.google.android.packageinstaller"
    private val INSTALLER_PACKAGE_INSTALLER_NOUGAT2 = "com.android.packageinstaller"

    private fun installedFromMarket(weakContext: WeakReference<out Context?>): Boolean {
        var result = false
        val context = weakContext.get()
        if (context != null) {
            try {
                val installer = context.packageManager.getInstallerPackageName(context.packageName)
                // if installer string is not null it might be installed by market
                if (!TextUtils.isEmpty(installer)) {
                    result = true

                    // on Android Nougat and up when installing an app through the package installer (which HockeyApp uses itself), the installer will be
                    // "com.google.android.packageinstaller" or "com.android.packageinstaller" which is also not to be considered as a market installation
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N && (TextUtils.equals(installer, INSTALLER_PACKAGE_INSTALLER_NOUGAT) || TextUtils.equals(installer, INSTALLER_PACKAGE_INSTALLER_NOUGAT2))) {
                        result = false
                    }

                    // on some devices (Xiaomi) the installer identifier will be "adb", which is not to be considered as a market installation
                    if (TextUtils.equals(installer, INSTALLER_ADB)) {
                        result = false
                    }
                }
            } catch (ignored: Throwable) {
            }
        }
        return result
    }

    private fun isPackageInstalled(packageName: String, packageManager: PackageManager): Boolean {
        return try {
            packageManager.getPackageInfo(packageName, 0)
            true
        } catch (e: PackageManager.NameNotFoundException) {
            false
        }
    }
}
