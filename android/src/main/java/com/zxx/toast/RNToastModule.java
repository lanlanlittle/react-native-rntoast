
package com.zxx.toast;

import android.widget.Toast;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReadableMap;

import java.util.HashMap;

public class RNToastModule extends ReactContextBaseJavaModule {

  private final ReactApplicationContext reactContext;

  public RNToastModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  @Override
  public String getName() {
    return "RNToast";
  }


  @ReactMethod
  public void show(ReadableMap map){
    HashMap<String, Object> mapJava = map.toHashMap();
    ToastManager.shareInstance().showToast(reactContext, mapJava);
  }

  @ReactMethod
  public void hide(){
    ToastManager.shareInstance().hideToast();
  }
}