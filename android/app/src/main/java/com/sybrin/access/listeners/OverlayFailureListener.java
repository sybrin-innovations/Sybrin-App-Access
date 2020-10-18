/*
 * Copyright (c) 2020 Sybrin Systems. All rights reserved.
 * Created by Armand Riley on  2020/10/01 1:36 PM
 *
 */

package com.sybrin.access.listeners;


import com.sybrin.access.exceptions.OverlayDrawingException;

//  Interface for the implementation of error handling in base overlay classes.
public interface OverlayFailureListener<T> {

    //  Functions
    void postFailure(OverlayDrawingException e);
    T addOnFailureListener(onFailureListener onFailureListener);

    //  Inner Classes
    public interface onFailureListener {
        void onFailure(OverlayDrawingException ie);
    }
}
