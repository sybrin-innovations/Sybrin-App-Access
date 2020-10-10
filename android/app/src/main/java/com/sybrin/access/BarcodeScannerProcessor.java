/*
 * Copyright 2020 Google LLC. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.sybrin.access;

import android.content.Context;
import android.graphics.Bitmap;
import android.widget.TextView;

import androidx.annotation.NonNull;

import com.google.android.gms.tasks.Task;
import com.google.mlkit.vision.barcode.Barcode;
import com.google.mlkit.vision.barcode.BarcodeScanner;
import com.google.mlkit.vision.barcode.BarcodeScannerOptions;
import com.google.mlkit.vision.barcode.BarcodeScanning;
import com.google.mlkit.vision.common.InputImage;
import com.sybrin.camera.processors.VisionImageProcessor;
import com.sybrin.camera.processors.VisionProcessorBase;

import java.util.List;

public class BarcodeScannerProcessor extends VisionProcessorBase<List<Barcode>> {
    private static final String TAG = "Sybrin:BarcodeProcessor";
    private final BarcodeScanner barcodeScanner;

    private onSuccessListener<String> onSuccessListener;
    private onFailureListener onFailureListener;

    public BarcodeScannerProcessor() {
        BarcodeScannerOptions barcodeOptions = new BarcodeScannerOptions.Builder()
                .setBarcodeFormats(Barcode.FORMAT_QR_CODE)
                .build();
        barcodeScanner = BarcodeScanning.getClient(barcodeOptions);
    }

    @Override
    public VisionImageProcessor addOnSuccessListener(onSuccessListener listener) {
        this.onSuccessListener = listener;
        return this;
    }

    @Override
    public VisionImageProcessor addOnFailureListener(onFailureListener listener) {
        this.onFailureListener = listener;
        return this;
    }

    @Override
    public void stop() {
        super.stop();
    }

    @Override
    public Task<List<Barcode>> detectInImage(InputImage image) {
        return barcodeScanner.process(image);
    }

    @Override
    public void onSuccess(
            @NonNull List<Barcode> barcodes, @NonNull Bitmap originalImage) {
        if (barcodes.size() != 0 && onSuccessListener != null){
            onSuccessListener.onSuccess(barcodes.get(0).getRawValue(), originalImage);
            onSuccessListener = null;
        }
    }

    @Override
    public void onFailure(@NonNull Exception e) {
        if (onFailureListener != null) {
            this.onFailureListener.onFailure(e);
            onSuccessListener = null;
        }

    }
}
