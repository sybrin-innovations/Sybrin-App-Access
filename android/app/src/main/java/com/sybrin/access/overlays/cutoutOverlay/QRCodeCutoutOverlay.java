package com.sybrin.access.overlays.cutoutOverlay;

import android.content.Context;
import android.graphics.Point;

import com.sybrin.access.overlays.strategies.CutoutOverlayBase;

public class QRCodeCutoutOverlay extends CutoutOverlayBase {

    //  Fields
    private Point qrCodeDimensions = new Point(1, 1);

    //  Constructors
    public QRCodeCutoutOverlay(Context context) {
        super(context);
    }

    //  Functions
    @Override
    public Point getDocumentDimensions() {
        return qrCodeDimensions;
    }
}
