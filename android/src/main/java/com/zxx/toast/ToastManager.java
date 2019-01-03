package com.zxx.toast;

import android.content.Context;
import android.view.View;
import android.widget.Toast;

import java.util.HashMap;

/**
 * Created by zhaoxx on 2019/1/3.
 */

public class ToastManager {
    private static ToastManager _instance = null;

    private Toast toast = null;
    public static ToastManager shareInstance(){
        if(_instance == null){
            _instance = new ToastManager();
        }
        return _instance;
    }

    public void showToast(Context context, HashMap<String, Object> map){
        hideToast();

        toast = new MessageToast(context);
        ((MessageToast)toast).showToast(map);
    }

    public void hideToast(){
        if(toast != null){
            toast.cancel();
            toast = null;
        }
    }
}
