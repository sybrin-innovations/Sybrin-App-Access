/*
 * Copyright (c) 2020 Sybrin Systems. All rights reserved.
 * Created by Armand Riley on  2020/10/01 1:36 PM
 *
 */

package com.sybrin.access.models.overlayModels;

import android.content.Context;
import android.content.res.Resources;
import android.graphics.Point;
import android.util.DisplayMetrics;
import android.view.Display;
import android.view.WindowManager;

//  Model used for describing the screen size.
public class ScreenDataModel {

    //  Fields
    private Point center;
    private int screenWidth;
    private int screenHeight;
    private int navigationBarHeight;

    //  Constructors
    public ScreenDataModel(Context context, int screenWidth, int screenHeight) {
        this.center = new Point((int)(screenWidth / 2f), (int)(screenHeight / 2f));
        this.screenWidth = screenWidth;
        this.screenHeight = screenHeight;
        this.navigationBarHeight = hasSoftKeys(context) ? getNavigationBarHeight(context) : 0;
    }

    //  Getters
    public Point getCenter() {
        return center;
    }

    public int getScreenWidth() {
        return screenWidth;
    }

    public int getScreenHeight() {
        return screenHeight;
    }

    public int getNavigationBarHeight() {
        return navigationBarHeight;
    }

    //  Functions
    public static int getNavigationBarHeight(Context context) {
        Resources resources = context.getResources();
        int resourceId = resources.getIdentifier("navigation_bar_height", "dimen", "android");
        return (resourceId > 0) ? resources.getDimensionPixelSize(resourceId) : 0;
    }

    public static boolean hasSoftKeys(Context context){
        WindowManager windowManager = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
        boolean hasSoftwareKeys = true;

        Display d = windowManager.getDefaultDisplay();

        DisplayMetrics realDisplayMetrics = new DisplayMetrics();
        d.getRealMetrics(realDisplayMetrics);

        int realHeight = realDisplayMetrics.heightPixels;
        int realWidth = realDisplayMetrics.widthPixels;

        DisplayMetrics displayMetrics = new DisplayMetrics();
        d.getMetrics(displayMetrics);

        int displayHeight = displayMetrics.heightPixels;
        int displayWidth = displayMetrics.widthPixels;

        hasSoftwareKeys =  (realWidth - displayWidth) > 0 ||
                (realHeight - displayHeight) > 0;
        return hasSoftwareKeys;
    }
}
