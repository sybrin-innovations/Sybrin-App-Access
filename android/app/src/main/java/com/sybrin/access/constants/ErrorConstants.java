/*
 * Copyright (c) 2020 Sybrin Systems. All rights reserved.
 * Created by Armand Riley on  2020/10/01 1:36 PM
 *
 */

package com.sybrin.access.constants;

//  Error messages used throughout the SDK.
public class ErrorConstants {
    public static String INIT_ERROR = "Sybrin Identity Init Error!";
    public static String NULL_SYBIRIN_IDENTITY_ERROR = "Sybrin Identity object not yet built. Run getInstance() before running getBuiltInstance()";
    public static String NULL_SYBIRIN_LISTENER_ERROR = "Sybrin Identity Listener is null. Set an IDCardListener, PassportListener or GreenBookListener by calling scanIDCard(), scanPassport() or scanGreenBook()";
    public static String METHOD_NOT_IMPLEMENTED = "There is not implementation for this method.";
    public static String SOUTHAFRICA_IDMODEL_NULL = "SouthAfricaIDModel == null. Set SouthAfricaIDCardModel using setModel().";
    public static String OVERLAYMODEL_BUILD_FAILURE = "Error building overlay model.";
    public static String OVERLAYMODEL_SET_DOCUMENT_DIMENSIONS_ERROR = "Error setting document dimensions in overlay model.";
    public static String BRANDTEXT_BUILD_FAILURE = "Error building brand text on overlay.";
    public static String INSTRUCTIONTEXT_BUILD_FAILURE = "Error building instructions text on overlay.";
    public static String VERIFICATIONTEXT_BUILD_FAILURE = "Error building verification text on overlay.";
    public static String SCANBAR_BUILD_FAILURE = "Error building scan bar on overlay.";
    public static String SCANBAR_ANIMATION_FAILURE = "Error animating scan bar.";
    public static String CUTOUT_OVERLAY_BUILD_FAILURE = "Error building overlay cutout on overlay.";
    public static String CARDTRANSISTIONANIMATION_BUILD_FAILURE = "Error building card transition animation on overlay.";
    public static String CARDTRANSISTION_ANIMATORSET_BUILD_FAILURE = "Error building card transition animator set on overlay.";
    public static String TORCHVIEW_BUILD_FAILURE = "Error building Torch view on overlay.";
}
