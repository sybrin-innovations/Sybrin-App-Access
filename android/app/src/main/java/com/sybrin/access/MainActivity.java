package com.sybrin.access;

import androidx.annotation.NonNull;

import com.google.gson.Gson;
import com.sybrin.access.models.ScanResultModel;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

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
