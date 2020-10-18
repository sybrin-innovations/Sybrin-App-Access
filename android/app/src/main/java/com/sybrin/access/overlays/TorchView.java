/*
 * Copyright (c) 2020 Sybrin Systems. All rights reserved.
 * Created by Armand Riley on  2020/10/09 4:52 PM
 *
 */

package com.sybrin.access.overlays;

import android.content.Context;
import android.graphics.Color;
import android.util.AttributeSet;
import android.view.ViewGroup;
import android.widget.LinearLayout;

import androidx.annotation.Nullable;

import com.sybrin.access.constants.ErrorConstants;
import com.sybrin.access.exceptions.OverlayDrawingException;
import com.sybrin.access.listeners.OverlayFailureListener;
import com.sybrin.access.models.overlayModels.OverlayModel;
import com.sybrin.camera.views.TorchViewBase;

//  Torch button that shows on overlay when document is being scanned.
public class TorchView extends TorchViewBase implements OverlayFailureListener<TorchViewBase> {

    //  Fields
    private OverlayModel overlayModel;
    private onFailureListener onFailureListener;

    //  Constructors
    public TorchView(Context context) {
        super(context);
    }

    public TorchView(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
    }

    public TorchView(Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
    }

    public TorchView(Context context, @Nullable AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
    }

    private void init(){
        setParams();
    }

    //  Setters
    public TorchViewBase setOverlayModel(OverlayModel overlayModel) {
        this.overlayModel = overlayModel;
        init();
        return this;
    }

    @Override
    public TorchViewBase addOnFailureListener(onFailureListener onFailureListener) {
        this.onFailureListener = onFailureListener;
        return this;
    }

    //  Functions
    private void setParams(){
        try {
            int width = (int)(overlayModel.getOverlayWidth() * 0.08);
            int height = (int)(overlayModel.getOverlayHeight() * 0.11);

            LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
            this.setLayoutParams(layoutParams);
            this.setX(overlayModel.getScreenData().getCenter().x + overlayModel.getWidthModifier() - width);
            this.setY(height / 4f);
            this.setColorFilter(Color.WHITE);
            this.getLayoutParams().width = width;
            this.getLayoutParams().height = height;
            this.requestLayout();
        } catch (Exception e) {
            postFailure(new OverlayDrawingException(ErrorConstants.TORCHVIEW_BUILD_FAILURE));
        }
    }

    @Override
    public void postFailure(OverlayDrawingException e) {
        this.onFailureListener.onFailure(e);
    }
}
