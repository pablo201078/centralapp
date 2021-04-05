package com.centralApp.central_app

import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity;


class MainActivity: FlutterActivity() {

    public override fun onPause() {
        super.onPause()
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_SECURE,
                WindowManager.LayoutParams.FLAG_SECURE);
    }

    public override fun onResume() {
        super.onResume();
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_SECURE,
                WindowManager.LayoutParams.FLAG_SECURE);
    }
}