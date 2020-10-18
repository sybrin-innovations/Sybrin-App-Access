package com.sybrin.access.overlays;

import android.content.Context;
import android.graphics.Color;

import com.sybrin.access.overlays.strategies.InstructionTextBase;

public class QRCodeInstructionText extends InstructionTextBase {
    public QRCodeInstructionText(Context context) {
        super(context);
    }

    @Override
    protected int getInstructionTextColor() {
        return Color.WHITE;
    }

    @Override
    protected float getYTranslation() {
        return this.getOverlayModel().getScreenData().getCenter().y - this.getOverlayModel().getHeightModifier() - (this.getTextSize() * 3);
    }

    @Override
    protected String[] getPhaseInstructions() {
        return new String[]{
                "Scan QRCode"
        };
    }

    @Override
    protected long getTransitionAnimationDuration() {
        return 700;
    }
}
