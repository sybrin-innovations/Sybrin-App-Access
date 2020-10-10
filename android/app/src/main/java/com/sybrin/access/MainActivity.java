package com.sybrin.access;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;

import com.google.gson.Gson;

import java.io.File;
import java.io.IOException;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.sybrin.access";
    private MethodChannel.Result localResult;
    private MethodCall localCall;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            localResult = result;
                            localCall = call;

                            if (localCall.method.equals("scanQRCode")) {
                                SybrinAccess.getInstance(getContext())
                                        .scanQRCode()
                                        .addOnSuccessListener(link -> postResultToFlutter(link))
                                        .addOnFailureListener(e -> localResult.error("500", e.getLocalizedMessage(), null));
                            }
                        }
                );
    }

    private void postResultToFlutter(String result) {
        ScanResultModel resultModel = new ScanResultModel();
        resultModel.success = true;
        resultModel.value = result;
        resultModel.message = "";

        String json = new Gson().toJson(resultModel);
        localResult.success(json);
    }
}
