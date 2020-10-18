/*
 * Copyright (c) 2020 Sybrin Systems. All rights reserved.
 * Created by Armand Riley on  2020/10/01 1:36 PM
 *
 */

package com.sybrin.access.overlays.strategies;


import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Point;
import android.view.View;

import com.sybrin.access.constants.ErrorConstants;
import com.sybrin.access.exceptions.OverlayDrawingException;
import com.sybrin.access.listeners.OverlayFailureListener;
import com.sybrin.access.models.overlayModels.OverlayModel;

//  Base class for the cutout overlay.
public abstract class CutoutOverlayBase extends View implements OverlayFailureListener<CutoutOverlayBase> {

    //  Fields
    private OverlayModel overlayModel;
    private onFailureListener onFailureListener;

    //  Constructors
    public CutoutOverlayBase(Context context) {
        super(context);
    }

    //  Setters
    @Override
    public CutoutOverlayBase addOnFailureListener(OverlayFailureListener.onFailureListener onFailureListener) {
        this.onFailureListener = onFailureListener;
        return this;
    }

    //  Functions
    public CutoutOverlayBase setOverlayModel(OverlayModel overlayModel) {
        this.overlayModel = overlayModel;
        return this;
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        try {
            canvas.drawBitmap(buildOverlayBitmap(), 0, 0, null);
        } catch (OverlayDrawingException e) {
            postFailure(e);
        }
    }

    public Bitmap buildOverlayBitmap() throws OverlayDrawingException {
        try {
            Bitmap bitmap = Bitmap.createBitmap(overlayModel.getOverlayWidth(), overlayModel.getOverlayHeight(), Bitmap.Config.ARGB_8888);
            Canvas canvas = new Canvas(bitmap);

            drawOverlay(canvas);
            drawCutout(canvas);
            drawBrackets(canvas);

            return bitmap;
        } catch (Exception e) {
            throw new OverlayDrawingException(ErrorConstants.CUTOUT_OVERLAY_BUILD_FAILURE);
        }
    }

    private void drawOverlay(Canvas canvas) {
        canvas.drawRect(overlayModel.getOverlayRect(), overlayModel.getOverlayPaint());
    }

    private void drawCutout(Canvas canvas) {
        Point center = overlayModel.getScreenData().getCenter();
        int widthModifier = overlayModel.getWidthModifier();
        int heightModifier = overlayModel.getHeightModifier();
        Paint transparentPaint = overlayModel.getTransparentPaint();

        canvas.drawRect(center.x - widthModifier, center.y - heightModifier, center.x + widthModifier, center.y + heightModifier, transparentPaint);
    }

    private void drawBrackets(Canvas canvas) {
        Point center = overlayModel.getScreenData().getCenter();
        int widthModifier = overlayModel.getWidthModifier();
        int heightModifier = overlayModel.getHeightModifier();
        Paint markerLinePaint = overlayModel.getMarkerLinePaint();
        int markerLineWidth = overlayModel.getMarkerLineWidth();
        int markerLineSize = overlayModel.getMarkerLineSize();

        //top left corner piece
        canvas.drawLine((center.x - widthModifier) - markerLineWidth, (center.y - heightModifier) - (markerLineWidth / 2f), (center.x - widthModifier) + markerLineSize, (center.y - heightModifier) - (markerLineWidth / 2f), markerLinePaint);
        canvas.drawLine((center.x - widthModifier) - (markerLineWidth / 2f), (center.y - heightModifier) - (markerLineWidth / 2f), (center.x - widthModifier) - (markerLineWidth / 2f), (center.y - heightModifier) + markerLineSize, markerLinePaint);

        //top right corner piece
        canvas.drawLine((center.x + widthModifier) + markerLineWidth, (center.y - heightModifier) - (markerLineWidth / 2f), (center.x + widthModifier) - markerLineSize, (center.y - heightModifier) - (markerLineWidth / 2f), markerLinePaint);
        canvas.drawLine((center.x + widthModifier) + (markerLineWidth / 2f), (center.y - heightModifier) - (markerLineWidth / 2f), (center.x + widthModifier) + (markerLineWidth / 2f), (center.y - heightModifier) + markerLineSize, markerLinePaint);

        //bottom right corner piece
        canvas.drawLine((center.x + widthModifier) + markerLineWidth, (center.y + heightModifier) + (markerLineWidth / 2f), (center.x + widthModifier) - markerLineSize, (center.y + heightModifier) + (markerLineWidth / 2f), markerLinePaint);
        canvas.drawLine((center.x + widthModifier) + (markerLineWidth / 2f), (center.y + heightModifier) + (markerLineWidth / 2f), (center.x + widthModifier) + (markerLineWidth / 2f), (center.y + heightModifier) - markerLineSize, markerLinePaint);

        //bottom left corner piece
        canvas.drawLine((center.x - widthModifier) - markerLineWidth, (center.y + heightModifier) + (markerLineWidth / 2f), (center.x - widthModifier) + markerLineSize, (center.y + heightModifier) + (markerLineWidth / 2f), markerLinePaint);
        canvas.drawLine((center.x - widthModifier) - (markerLineWidth / 2f), (center.y + heightModifier) + (markerLineWidth / 2f), (center.x - widthModifier) - (markerLineWidth / 2f), (center.y + heightModifier) - markerLineSize, markerLinePaint);
    }

    @Override
    public void postFailure(OverlayDrawingException e) {
        if (null != this.onFailureListener)
            this.onFailureListener.onFailure(e);
    }

    //  Abstract Methods
    abstract public Point getDocumentDimensions();
}
