package com.venturevault.solitaire_p1;

import android.os.Handler;
import android.os.Message;
import androidx.annotation.Keep;

@Keep
public class SolitaireHHH extends Handler {
    @Keep
    public SolitaireHHH() {

    }
    @Keep
    @Override
    public void handleMessage(Message message) {
        int r0 = message.what;
        SolitaireLLL.SolitaireBBB(r0);
    }
}

