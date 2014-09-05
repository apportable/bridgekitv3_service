package com.apportable.bkservice;

import android.app.Service;
import android.os.Bundle;
import android.os.IBinder;
import android.content.Intent;

import com.apportable.RuntimeService;

/**
 * To start me from ADB commandline:
 *   adb shell am startservice --user 0 -n com.apportable.bkservice/.bkserviceService
 */
public class bkserviceService extends Service {
    @Override
    public void onCreate() {
        // To successfully execute native code, whether launched directly 
        // or indirectly the Apportable system libraries must be loaded.
        new RuntimeService(this).loadLibraries();
        run();
    }
    public native void run();

    @Override
    public IBinder onBind(Intent arg0) {
        // TODO Auto-generated method stub
        return null;
    }

    // To restart the service automatically after being killed due to memory
    // pressure, uncomment this method.
    // @Override
    // public int onStartCommand(Intent intent, int flags, int startId) {
    //     // We want this service to continue running until it is explicitly
    //     // stopped, so return sticky.
    //     return START_STICKY;
    // }
}
