package com.apportable.bkservice;

import android.app.Activity;
import android.os.Bundle;

import com.apportable.RuntimeService;

public class bkserviceActivity extends Activity {
    @Override
    protected void onCreate(final Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        new RuntimeService(this).loadLibraries();
        run();
    }
    public native void run();
}