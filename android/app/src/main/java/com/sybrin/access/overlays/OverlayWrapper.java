/*
 * Copyright (c) 2020 Sybrin Systems. All rights reserved.
 * Created by Armand Riley on  2020/10/01 1:36 PM
 *
 */

package com.sybrin.access.overlays;

import android.content.Context;
import android.graphics.Canvas;
import android.util.AttributeSet;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.sybrin.access.exceptions.OverlayDrawingException;
import com.sybrin.access.models.overlayModels.OverlayModel;
import com.sybrin.access.overlays.strategies.BrandTextBase;
import com.sybrin.access.overlays.strategies.CutoutOverlayBase;
import com.sybrin.access.overlays.strategies.InstructionTextBase;
import com.sybrin.access.overlays.strategies.OverlayWrapperBase;


//  Class to wrap all overlay components and manage their state.
public class OverlayWrapper extends OverlayWrapperBase {

    //  Fields
    private boolean initialized = false;

    private OverlayModel overlayModel;
    private BrandTextBase brandText;
    private InstructionTextBase instructionText;
    private CutoutOverlayBase cutoutOverlay;
    private TorchView torchView;

    //  Constructors
    public OverlayWrapper(@NonNull Context context) {
        super(context);
    }

    public OverlayWrapper(@NonNull Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
    }

    public OverlayWrapper(@NonNull Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
    }

    public OverlayWrapper(@NonNull Context context, @Nullable AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
    }

    private OverlayWrapper(Context context, Builder builder) {
        super(context);
        this.brandText = builder.brandText;
        this.instructionText = builder.instructionText;
        this.cutoutOverlay = builder.cutoutOverlay;
        this.torchView = builder.torchView;
        initFailures();
    }

    public void cloneFrom(OverlayWrapper overlayWrapper) {
        this.brandText = overlayWrapper.brandText;
        this.instructionText = overlayWrapper.instructionText;
        this.cutoutOverlay = overlayWrapper.cutoutOverlay;
        this.torchView = overlayWrapper.torchView;
        initFailures();

        this.invalidate();
    }

    private void initFailures() {
        if (null != this.cutoutOverlay)
            this.cutoutOverlay.addOnFailureListener(this::postFailure);

        if (null != this.brandText)
            this.brandText.addOnFailureListener(this::postFailure);

        if (null != this.instructionText)
            this.instructionText.addOnFailureListener(this::postFailure);
    }

    //  Getters
    public BrandTextBase getBrandText() {
        return brandText;
    }

    public InstructionTextBase getInstructionText() {
        return instructionText;
    }

    public CutoutOverlayBase getCutoutOverlay() {
        return cutoutOverlay;
    }

    public TorchView getTorchView() {
        return torchView;
    }

    //  Functions
    @Override
    protected void dispatchDraw(Canvas canvas) {
        super.dispatchDraw(canvas);

        try {
            if (!initialized) {
                buildLayout(this.getWidth(), this.getHeight());

                if (this.getChildCount() != 0) {
                    initialized = true;
                }
            }
        } catch (OverlayDrawingException e) {
            this.postFailure(e);
        } catch (Exception e) {
            this.postFailure(new OverlayDrawingException(e.getLocalizedMessage()));
        }
    }

    private void buildLayout(int layoutWith, int layoutHeight) throws OverlayDrawingException {
        if (null != this.cutoutOverlay) {
            this.overlayModel = new OverlayModel(getContext(), layoutWith, layoutHeight)
                    .setDocumentDimensions(this.cutoutOverlay.getDocumentDimensions());

            if (null != this.cutoutOverlay)
                this.addView(this.cutoutOverlay.setOverlayModel(overlayModel));

            if (null != this.brandText)
                this.addView(this.brandText.setOverlayModel(overlayModel));

            if (null != this.instructionText)
                this.addView(this.instructionText.setOverlayModel(overlayModel));

            if (null != this.torchView)
                this.addView(this.torchView.setOverlayModel(overlayModel));
        }
    }

    @Override
    public void updateForNextPhase() {
        this.runOnUI(() -> {
            if (null != this.instructionText)
                this.instructionText.showNextPhaseText();
        });
    }

    @Override
    public void updateForPreviousPhase() {
        throw new UnsupportedOperationException();
    }

    @Override
    public void updateVerificationText(String verificationValue) {
        throw new UnsupportedOperationException();
    }

    //  Inner Classes
    public static class Builder {

        //  Fields
        private BrandTextBase brandText;
        private InstructionTextBase instructionText;
        private CutoutOverlayBase cutoutOverlay;
        private TorchView torchView;

        //  Setters
        public Builder setBrandText(BrandTextBase brandText) {
            this.brandText = brandText;
            return this;
        }

        public Builder setInstructionText(InstructionTextBase instructionText) {
            this.instructionText = instructionText;
            return this;
        }

        public Builder setCutoutOverlay(CutoutOverlayBase cutoutOverlay) {
            this.cutoutOverlay = cutoutOverlay;
            return this;
        }


        public Builder setTorchView(TorchView torchView) {
            this.torchView = torchView;
            return this;
        }

        //  Functions
        public OverlayWrapper build(Context context) {
            return new OverlayWrapper(context, this);
        }
    }
}
