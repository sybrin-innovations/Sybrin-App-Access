/*
 * Copyright (c) 2020 Sybrin Systems. All rights reserved.
 * Created by Armand Riley on  2020/10/01 1:36 PM
 *
 */

package com.sybrin.access.overlays.strategies;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.util.AttributeSet;
import android.widget.FrameLayout;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.sybrin.access.exceptions.OverlayDrawingException;
import com.sybrin.access.listeners.OverlayFailureListener;

//  Base class for wrapping of overlay elements and managing overlay state.
abstract public class OverlayWrapperBase extends FrameLayout implements OverlayFailureListener<OverlayWrapperBase> {

    //  Fields
    private onFailureListener onFailureListener;
    private Handler uiHandler;

    //  Constructors
    public OverlayWrapperBase(@NonNull Context context) {
        super(context);
        init();
    }

    public OverlayWrapperBase(@NonNull Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
        init();
    }

    public OverlayWrapperBase(@NonNull Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init();
    }

    public OverlayWrapperBase(@NonNull Context context, @Nullable AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
        init();
    }

    private void init(){
        this.uiHandler = new Handler(Looper.getMainLooper());
    }

    //  Setters
    @Override
    public OverlayWrapperBase addOnFailureListener(onFailureListener onFailureListener) {
        this.onFailureListener = onFailureListener;
        return this;
    }

    //  Functions
    @Override
    public void postFailure(OverlayDrawingException e) {
        if (null != this.onFailureListener)
            this.onFailureListener.onFailure(e);
    }

    protected void runOnUI(Runnable runnable) {
        if (null != runnable)
            uiHandler.post(runnable);
    }

    //  Abstract Methods
    abstract public void updateForNextPhase();

    abstract public void updateForPreviousPhase();

    abstract public void updateVerificationText(String verificationValue);

}
