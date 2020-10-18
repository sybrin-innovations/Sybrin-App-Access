/*
 * Copyright (c) 2020 Sybrin Systems. All rights reserved.
 * Created by Armand Riley on  2020/10/01 1:36 PM
 *
 */

package com.sybrin.access.overlays;

import android.content.Context;
import android.graphics.Color;

import com.sybrin.access.overlays.strategies.BrandTextBase;

//  Branding for the innovations branding at the bottom of the overlay.
public class InnovationsBrandText extends BrandTextBase {

    //  Constructors
    public InnovationsBrandText(Context context) {
        super(context);
    }

    //  Getters
    @Override
    public String getBrandTitleText(){
        return "INNOVATIONS LAB";
    };

    @Override
    public String getBrandSubtitleText(){
        return "A DIVISION OF SYBRIN";
    };

    @Override
    public int getBrandTitleTextColor() {
        return Color.WHITE;
    }

    @Override
    public int getBrandSubtitleTextColor() {
        return Color.WHITE;
    }
}
