package com.sybrin.access;

import android.Manifest;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import com.sybrin.access.overlays.InnovationsBrandText;
import com.sybrin.access.overlays.OverlayWrapper;
import com.sybrin.access.overlays.QRCodeInstructionText;
import com.sybrin.access.overlays.TorchView;
import com.sybrin.access.overlays.cutoutOverlay.QRCodeCutoutOverlay;
import com.sybrin.access.processors.BarcodeScannerProcessor;
import com.sybrin.camera.camera.CameraSource;
import com.sybrin.camera.camera.CameraSourcePreview;
import com.sybrin.camera.processors.VisionImageProcessor;
import com.sybrin.extensions.handlers.handlers.PermissionsHandler;

public class CameraActivity extends AppCompatActivity {
    private CameraSource cameraSource = null;
    private CameraSourcePreview preview;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.camera_main);

        preview = findViewById(R.id.preview);

        String[] permissions = new String[]{Manifest.permission.CAMERA};
        boolean permissionsResult = PermissionsHandler.checkPermissions(CameraActivity.this, permissions, () -> launchCamera());
        if (permissionsResult) {
            launchCamera();
        }
    }

    private VisionImageProcessor buildProcessor() {
        String verificationUrl = this.getResources().getString(R.string.qrCodeValidationString);
        return new BarcodeScannerProcessor(verificationUrl).addOnSuccessListener((result, bitmap) -> {
            if (result instanceof String) {
                SybrinAccess.getInstance(getApplicationContext()).postSuccess(this.getResources().getString(R.string.microsoftFormPostUrl));
                finish();
            }
        }).addOnFailureListener(e -> {
            SybrinAccess.getInstance(getApplicationContext()).postFailure(e);
            finish();
        });
    }

    private void launchCamera() {
        cameraSource = CameraSource.createCamera(CameraActivity.this, preview, 640, 480);
        cameraSource.setFrameProcessor(buildProcessor());
        buildOverlay();
    }

    private void buildOverlay(){
        OverlayWrapper wrapper = findViewById(R.id.overlayWrapper);
        OverlayWrapper overlay = new OverlayWrapper.Builder()
                .setCutoutOverlay(new QRCodeCutoutOverlay(getApplicationContext()))
                .setBrandText(new InnovationsBrandText(getApplicationContext()))
                .setInstructionText(new QRCodeInstructionText(getApplicationContext()))
                .setTorchView(new TorchView(getApplicationContext()))
                .build(getApplicationContext());

        wrapper.cloneFrom(overlay);
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (null != cameraSource) {
            cameraSource.startCameraSource(preview);
        }
    }

    @Override
    protected void onPause() {
        super.onPause();
        preview.stop();
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        if (cameraSource != null) {
            cameraSource.release();
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        PermissionsHandler.onPermissionResult(grantResults);
    }
}
