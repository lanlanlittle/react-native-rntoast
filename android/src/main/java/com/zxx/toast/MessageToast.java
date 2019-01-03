package com.zxx.toast;

import android.animation.AnimatorSet;
import android.animation.ObjectAnimator;
import android.content.Context;
import android.graphics.Color;
import android.graphics.drawable.GradientDrawable;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.animation.AccelerateDecelerateInterpolator;
import android.widget.TextView;
import android.widget.Toast;

import java.util.HashMap;

/**
 * Created by zhaoxx on 2019/1/3.
 */

public class MessageToast extends Toast {
    private Context mContext = null;
    public MessageToast(Context context) {
        super(context);

        mContext = context;
    }

    /**
     text 文本信息
     font 字体大小
     backgroundColor 背景色
     textColor 文字颜色
     borderColor 边框颜色
     borderWidth 边框粗细
     cornerRadius 边框圆角
     edgeInsets 内边距 top上 left左 bottom下 right右
     interval 动画时长
     transformY y轴变换距离
     endAlpha 结束时的透明度
     */
    public void showToast(HashMap<String, Object> map){
        int interval = 20000;
        if(map.get("interval") != null){
            interval = (int)Float.parseFloat(map.get("interval").toString());
            interval = interval*1000;
        }
        String textColor = "#ffffffff";
        if(map.get("textColor") != null){
            textColor = map.get("textColor").toString();
        }
        String backgroundColor = "#ff000000";
        if(map.get("backgroundColor") != null){
            backgroundColor = map.get("backgroundColor").toString();
        }
        float cornerRadius = 0;
        if(map.get("cornerRadius") != null){
            cornerRadius = Float.parseFloat(map.get("cornerRadius").toString());
        }
        int borderWidth = 0;
        if(map.get("borderWidth") != null){
            borderWidth = (int)Float.parseFloat(map.get("borderWidth").toString());
        }
        String borderColor = "#ff000000";
        if(map.get("borderColor") != null){
            borderColor = map.get("borderColor").toString();
        }
        int transformY = 0;
        if(map.get("transformY") != null){
            transformY = (int)Float.parseFloat(map.get("transformY").toString());
        }
        float endAlpha = 0;
        if(map.get("endAlpha") != null){
            endAlpha = Float.parseFloat(map.get("endAlpha").toString());
        }
        String text = "";
        if(map.get("text") != null){
            text = map.get("text").toString();
        }
        float font = 20;
        if(map.get("font") != null){
            font = Float.parseFloat(map.get("font").toString());
        }
        HashMap<String, Object> edgeInsets = new HashMap<>();
        edgeInsets.put("top", 0);
        edgeInsets.put("left", 0);
        edgeInsets.put("bottom", 0);
        edgeInsets.put("right", 0);
        if(map.get("edgeInsets") != null){
            edgeInsets = (HashMap<String, Object>)map.get("edgeInsets");
        }

        View view = LayoutInflater.from(mContext).inflate(R.layout.toast_layout, null);
        this.setView(view);
        this.setGravity(Gravity.CENTER, 0, 0);
        this.setDuration(interval);

        TextView textView = (TextView) view.findViewById(R.id.textView);
        if(textView != null){
            textView.setText(text);
            textView.setTextSize(font);
            textView.setTextColor(Color.parseColor(textColor));
            GradientDrawable gradientDrawable = (GradientDrawable) textView.getBackground();
            if(gradientDrawable != null){
                gradientDrawable.setColor(Color.parseColor(backgroundColor));
                gradientDrawable.setCornerRadius(cornerRadius);
                gradientDrawable.setStroke(borderWidth, Color.parseColor(borderColor));
                textView.setPadding((int)Float.parseFloat(edgeInsets.get("left").toString()),
                        (int)Float.parseFloat(edgeInsets.get("top").toString()),
                        (int)Float.parseFloat(edgeInsets.get("right").toString()),
                        (int)Float.parseFloat(edgeInsets.get("bottom").toString()));
            }
        }

        AnimatorSet set = new AnimatorSet();
        ObjectAnimator togTransformY = ObjectAnimator.ofFloat(view, "translationY", 0f, transformY);
        ObjectAnimator togAlpha = ObjectAnimator.ofFloat(view, "alpha", 1.0f, 1.0f, endAlpha);
        set.playTogether(togTransformY, togAlpha);
        set.setDuration(interval);
        set.setInterpolator(new AccelerateDecelerateInterpolator());
        set.start();

        this.show();
    }
}
