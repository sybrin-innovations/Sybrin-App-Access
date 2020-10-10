package com.sybrin.access;

import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;

public class SybrinAccess extends ContextWrapper {
    private static SybrinAccess single_instance = null;
    private onFailureListener onFailureListener;
    private onSuccessListener onSuccessListener;

    public SybrinAccess(Context base) {
        super(base);
    }

    public static SybrinAccess getInstance(Context context) {
        if (single_instance == null)
            single_instance = new SybrinAccess(context);

        return single_instance;
    }

    public SybrinAccess addOnSuccessListener(onSuccessListener listener) {
        this.onSuccessListener = listener;
        return this;
    }

    public SybrinAccess addOnFailureListener(onFailureListener listener) {
        this.onFailureListener = listener;
        return this;
    }

    public void postSuccess(String result){
        this.onSuccessListener.onSuccess(result);
    }

    public void postFailure(Exception e){
        this.onFailureListener.onFailure(e);
    }

    public SybrinAccess scanQRCode(){
        Intent i = new Intent(getApplicationContext(), CameraActivity.class);
        startActivity(i);
        return this;
    }

    //  Inner Classes
    public interface onSuccessListener {
        void onSuccess(String link);
    }

    public interface onFailureListener {
        void onFailure(Exception e);
    }
}
