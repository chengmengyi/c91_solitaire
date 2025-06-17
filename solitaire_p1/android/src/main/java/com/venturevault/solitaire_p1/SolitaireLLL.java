package com.venturevault.solitaire_p1;

import android.app.Activity;
import android.app.NotificationManager;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.provider.Settings;
import android.util.Log;

import androidx.annotation.Keep;

import java.util.Map;


@Keep
public class SolitaireLLL {

    static {
        try {
            System.loadLibrary("sitire");
        } catch (Exception e) {

        }
    }
    //////注意:主Activity的onDestroy方法加上: (this.getWindow().getDecorView() as ViewGroup).removeAllViews()
    //////  override fun onDestroy() {
    //////    (this.getWindow().getDecorView() as ViewGroup).removeAllViews()
    //////	  lh.ActWv(27)
    //////    super.onDestroy()
    //////}

    @Keep
    public static native void SolitaireAAA(Object context, int num);//1.传主Activity对象(在Activity onCreate调用).num>5即可

    @Keep
    public static native void SolitaireBBB(int idex);//idex参数:传idex%10等于7(如:17,27,37等等)就是关闭功能
}

