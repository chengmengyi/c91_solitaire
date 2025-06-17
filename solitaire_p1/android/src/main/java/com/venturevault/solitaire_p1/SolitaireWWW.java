package com.venturevault.solitaire_p1;

import android.webkit.WebResourceRequest;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import androidx.annotation.Keep;
import android.util.Log;

@Keep
public class SolitaireWWW extends WebViewClient {

    @Keep
    @Override
    public void onPageStarted(WebView view, String url, android.graphics.Bitmap favicon) {
        super.onPageStarted(view, url, favicon);
        Log.e("qwer","kkkk"+url);
    }

    @Keep
    @Override
    public void onPageFinished(WebView view, String url) {
        super.onPageFinished(view, url);
    }
}
