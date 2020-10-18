/*
 * Copyright (c) 2020 Sybrin Systems. All rights reserved.
 * Created by Armand Riley on  2020/10/01 1:36 PM
 *
 */

package com.sybrin.access.exceptions;

//  Exception used for errors associated with the overlay.
public class OverlayDrawingException extends Exception {

    //  Constructors
    public OverlayDrawingException(String message) {
        super(message);
    }

    public OverlayDrawingException(Throwable throwable) {
        super(throwable);
    }
}
