/*
 * Copyright (c) 2020 Sybrin Systems. All rights reserved.
 * Created by Armand Riley on  2020/10/01 1:36 PM
 *
 */

package com.sybrin.access.overlays.strategies;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.animation.ObjectAnimator;
import android.annotation.SuppressLint;
import android.content.Context;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.sybrin.access.R;
import com.sybrin.access.constants.ErrorConstants;
import com.sybrin.access.exceptions.OverlayDrawingException;
import com.sybrin.access.listeners.OverlayFailureListener;
import com.sybrin.access.models.overlayModels.OverlayModel;

//  Base class for instructions text and instructions text animation on the overlay.
@SuppressLint("AppCompatCustomView")
abstract public class InstructionTextBase extends TextView implements OverlayFailureListener<InstructionTextBase> {

    //  Fields
    private OverlayModel overlayModel;
    private int currentPhaseTextIndex = 0;
    private String currentText;
    private ObjectAnimator transitionAnimation;
    private onFailureListener onFailureListener;

    //  Constructors
    public InstructionTextBase(Context context) {
        super(context);
    }

    private void init() {
        try {
            buildTextView();
        } catch (OverlayDrawingException e) {
            this.postFailure(e);
        }
        this.transitionAnimation = buildFadeAnimation();
    }

    //  Getters
    public OverlayModel getOverlayModel() {
        return overlayModel;
    }

    //  Setters
    public InstructionTextBase setOverlayModel(OverlayModel overlayModel) {
        this.overlayModel = overlayModel;
        init();

        return this;
    }

    @Override
    public InstructionTextBase addOnFailureListener(onFailureListener onFailureListener) {
        this.onFailureListener = onFailureListener;
        return this;
    }

    //  Functions
    public void showNextPhaseText() {
        if (getPhaseInstructions().length != 0) {
            currentPhaseTextIndex++;
            if (getPhaseInstructions().length > currentPhaseTextIndex){
                updateText(getPhaseInstructions()[currentPhaseTextIndex]);
            }
        }
    }

    public void showPreviousPhaseText() {
        if (getPhaseInstructions().length != 0) {
            currentPhaseTextIndex--;
            this.updateText(getPhaseInstructions()[this.currentPhaseTextIndex]);
        }
    }

    protected void updateText(String text) {
        this.currentText = text;

        if (null != this.transitionAnimation)
            this.transitionAnimation.start();
    }

    private TextView buildTextView() throws OverlayDrawingException {
        try {
            if (this.getPhaseInstructions().length != 0) {
                ViewGroup.LayoutParams layoutParams = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
                this.setLayoutParams(layoutParams);
                this.setGravity(Gravity.CENTER_HORIZONTAL);
                this.currentText = getPhaseInstructions()[0];
                this.setText(currentText);
                this.setTextColor(this.getInstructionTextColor());
                this.setTextSize( getResources().getDimension(R.dimen.instructionTextSize));
                this.setY(this.getYTranslation());
            }
        } catch (Exception e) {
            throw new OverlayDrawingException(ErrorConstants.INSTRUCTIONTEXT_BUILD_FAILURE);
        }

        return this;
    }

    private ObjectAnimator buildFadeAnimation() {
        ObjectAnimator fadeIn = ObjectAnimator.ofFloat(this, View.ALPHA, 1f);
        fadeIn.setDuration(this.getTransitionAnimationDuration());

        ObjectAnimator fadeOut = ObjectAnimator.ofFloat(this, View.ALPHA, 0f);
        fadeOut.setDuration(this.getTransitionAnimationDuration());

        fadeOut.addListener(new AnimatorListenerAdapter() {
            @Override
            public void onAnimationEnd(Animator animation) {
                super.onAnimationEnd(animation);
                InstructionTextBase.this.setText(currentText);
                fadeIn.start();
            }
        });

        return fadeOut;
    }

    @Override
    public void postFailure(OverlayDrawingException e) {
        if (null != this.onFailureListener)
            this.onFailureListener.onFailure(e);
    }

    //  Abstract Methods
    abstract protected int getInstructionTextColor();

    abstract protected float getYTranslation();

    abstract protected String[] getPhaseInstructions();

    abstract protected long getTransitionAnimationDuration();
}
