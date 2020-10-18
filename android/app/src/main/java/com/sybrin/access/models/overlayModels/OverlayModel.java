/*
 * Copyright (c) 2020 Sybrin Systems. All rights reserved.
 * Created by Armand Riley on  2020/10/01 1:36 PM
 *
 */

package com.sybrin.access.models.overlayModels;

import android.content.Context;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Point;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffXfermode;
import android.graphics.Rect;
import android.graphics.RectF;
import android.util.DisplayMetrics;
import android.view.Display;
import android.view.WindowManager;

import com.sybrin.access.constants.ErrorConstants;
import com.sybrin.access.exceptions.OverlayDrawingException;

//  Model used by the DocumentCutoutOverlay to manage and build its internal data.
public class OverlayModel {

    //  Fields
    private int markerLineSize = 40;
    private int markerLineWidth = 7;
    private double horizontalScreenCutoutAllocation = 0.75;

    private Point documentDimensions;
    private int overlayWidth;
    private int overlayHeight;
    private Paint markerLinePaint;
    private Paint overlayPaint;
    private Paint transparentPaint;
    private RectF overlayRect;
    private ScreenDataModel screenData;
    private int widthModifier;
    private int heightModifier;
    private Rect cutoutDimensions;

    //  Constructors
    public OverlayModel(Context context, int overlayWidth, int overlayHeight) throws OverlayDrawingException {
        try {
            this.overlayWidth = overlayWidth;
            this.overlayHeight = overlayHeight;
            this.screenData = getScreenData(context);
            this.markerLinePaint = buildMarkerLinePaint();
            this.overlayPaint = buildOverlayPaint();
            this.transparentPaint = buildTransparentPaint();
            this.overlayRect = buildOverlayRect(this.overlayWidth, this.overlayHeight);
        } catch (Exception e) {
            throw new OverlayDrawingException(ErrorConstants.OVERLAYMODEL_BUILD_FAILURE);
        }
    }

    //  Getters
    public int getMarkerLineSize() {
        return markerLineSize;
    }

    public Paint getMarkerLinePaint() {
        return markerLinePaint;
    }

    public int getMarkerLineWidth() {
        return markerLineWidth;
    }

    public ScreenDataModel getScreenData() {
        return screenData;
    }

    public Paint getOverlayPaint() {
        return overlayPaint;
    }

    public Paint getTransparentPaint() {
        return transparentPaint;
    }

    public RectF getOverlayRect() {
        return overlayRect;
    }

    public int getWidthModifier() {
        return widthModifier;
    }

    public int getHeightModifier() {
        return heightModifier;
    }

    public int getOverlayWidth() {
        return overlayWidth;
    }

    public int getOverlayHeight() {
        return overlayHeight;
    }

    public Rect getCutoutDimensions() {
        return cutoutDimensions;
    }

    //  Setters
    public OverlayModel setDocumentDimensions(Point documentDimensions) throws OverlayDrawingException {
        try {
            this.documentDimensions = documentDimensions;

            this.widthModifier = calcWithModifier();
            this.heightModifier = calcHeightModifier(this.widthModifier);


            int left = (getScreenData().getCenter().x - widthModifier);
            int top = (getScreenData().getCenter().y - heightModifier);
            int width = (getScreenData().getCenter().x + widthModifier);
            int height = (getScreenData().getCenter().y + heightModifier);
            this.cutoutDimensions = new Rect(left,top,width ,height);
        } catch (Exception e) {
            throw new OverlayDrawingException(ErrorConstants.OVERLAYMODEL_SET_DOCUMENT_DIMENSIONS_ERROR);
        }

        return this;
    }

    public void setMarkerLineSize(int markerLineSize) {
        this.markerLineSize = markerLineSize;
    }

    public void setMarkerLineWidth(int markerLineWidth) {
        this.markerLineWidth = markerLineWidth;
    }

    //  Functions
    private int calcWithModifier() {
        int widthModifier = (int) (this.screenData.getCenter().x * this.horizontalScreenCutoutAllocation);
        return widthModifier;
    }

    private int calcHeightModifier(int widthModifier) {
        int totalWidth = widthModifier * 2;
        int newHeight = Math.round(totalWidth / (documentDimensions.x / (float) documentDimensions.y));
        int heightModifier = (int) (newHeight / 2f);
        return heightModifier;
    }

    private ScreenDataModel getScreenData(Context context) {
        WindowManager wm = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
        Display display = wm.getDefaultDisplay();

        DisplayMetrics metrics = new DisplayMetrics();
        display.getMetrics(metrics);

        return new ScreenDataModel(context, metrics.widthPixels, metrics.heightPixels);
    }

    private Paint buildMarkerLinePaint() {
        Paint markerLinePaint = new Paint();
        markerLinePaint.setColor(Color.WHITE);
        markerLinePaint.setStrokeWidth(markerLineWidth);
        markerLinePaint.setStyle(Paint.Style.STROKE);
        return markerLinePaint;
    }

    private Paint buildOverlayPaint() {
        Paint overlayPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
        overlayPaint.setColor(Color.argb(80, Color.red(Color.BLACK), Color.green(Color.BLACK), Color.blue(Color.BLACK)));
        return overlayPaint;
    }

    private Paint buildTransparentPaint() {
        Paint transparentPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
        transparentPaint.setColor(Color.TRANSPARENT);
        transparentPaint.setXfermode(new PorterDuffXfermode(PorterDuff.Mode.SRC_OUT));
        return transparentPaint;
    }

    private RectF buildOverlayRect(int overlayWidth, int overlayHeight) {
        return new RectF(0, 0, overlayWidth, overlayHeight);
    }


}
