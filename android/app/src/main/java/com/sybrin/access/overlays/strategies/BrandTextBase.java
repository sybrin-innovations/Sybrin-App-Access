/*
 * Copyright (c) 2020 Sybrin Systems. All rights reserved.
 * Created by Armand Riley on  2020/10/01 1:36 PM
 *
 */

package com.sybrin.access.overlays.strategies;

import android.content.Context;
import android.graphics.Typeface;
import android.view.Gravity;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.sybrin.access.R;
import com.sybrin.access.constants.ErrorConstants;
import com.sybrin.access.exceptions.OverlayDrawingException;
import com.sybrin.access.listeners.OverlayFailureListener;
import com.sybrin.access.models.overlayModels.OverlayModel;

//  Base class for branding text on the overlay.
abstract public class BrandTextBase extends LinearLayout implements OverlayFailureListener<BrandTextBase> {

    //  Fields
    private OverlayModel overlayModel;
    private onFailureListener onFailureListener;

    //  Constructors
    public BrandTextBase(Context context) {
        super(context);
    }

    private void init() {
        try {
            ViewGroup.LayoutParams layoutParams = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
            this.setLayoutParams(layoutParams);
            this.setOrientation(LinearLayout.VERTICAL);
            this.setGravity(Gravity.BOTTOM);
            this.setPadding(0, 0, 0, 20 + overlayModel.getScreenData().getNavigationBarHeight());

            TextView titleView = buildTextView(getBrandTitleText(), getBrandTitleTextColor(), getResources().getDimension(R.dimen.brandTitleTextSize));
            TextView subTitleView = buildTextView(getBrandSubtitleText(), getBrandSubtitleTextColor(), getResources().getDimension(R.dimen.brandSubtitleTextSize));

            this.addView(titleView);
            this.addView(subTitleView);
        } catch (OverlayDrawingException e) {
            this.postFailure(e);
        }
    }

    //  Getters
    public OverlayModel getOverlayModel() {
        return overlayModel;
    }

    //  Setters
    public BrandTextBase setOverlayModel(OverlayModel overlayModel) {
        this.overlayModel = overlayModel;
        init();

        return this;
    }

    @Override
    public BrandTextBase addOnFailureListener(onFailureListener onFailureListener) {
        this.onFailureListener = onFailureListener;
        return this;
    }

    //  Functions
    private TextView buildTextView(String text, int textColor, float textSize) throws OverlayDrawingException {
        try {
            ViewGroup.LayoutParams textParams = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);

            TextView textView = new TextView(getContext());
            textView.setGravity(Gravity.CENTER);
            textView.setLayoutParams(textParams);
            textView.setText(text);
            textView.setTextColor(textColor);
            textView.setTextSize(textSize);
            textView.setTypeface(textView.getTypeface(), Typeface.BOLD);

            return textView;
        } catch (Exception e) {
            throw new OverlayDrawingException(ErrorConstants.BRANDTEXT_BUILD_FAILURE);
        }
    }

    @Override
    public void postFailure(OverlayDrawingException e) {
        if (null != this.onFailureListener)
            this.onFailureListener.onFailure(e);
    }

    //  Abstract Methods
    abstract protected String getBrandTitleText();

    abstract protected String getBrandSubtitleText();

    abstract protected int getBrandTitleTextColor();

    abstract protected int getBrandSubtitleTextColor();

}
