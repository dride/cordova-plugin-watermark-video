/*
 * Copyright 2018 Myles McNamara
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */
package watermark;

import org.apache.cordova.*;

import java.util.List;
import java.util.concurrent.Future;
import java.lang.InterruptedException;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.pm.PackageManager;
import android.content.BroadcastReceiver;
import android.content.Intent;
import android.content.IntentFilter;


import android.content.Context;
import android.os.AsyncTask;
import android.util.Log;
import android.os.Build.VERSION;


public class Watermark extends CordovaPlugin {

  private static final String TAG = "Watermark";
  private static final int API_VERSION = VERSION.SDK_INT;

  private static final String ADD_WATERMARK_TO_VIDEO = "addWatermarkToVideo";


  @Override
  public boolean execute(String action, JSONArray data, CallbackContext callbackContext)
      throws JSONException {

    // Actions that DO require WiFi to be enabled
    if (action.equals(ADD_WATERMARK_TO_VIDEO)) {
      this.addWatermarkToVideo(callbackContext, data);
    } else {
      callbackContext.error("Incorrect action parameter: " + action);
      // The ONLY time to return FALSE is when action does not exist that was called
      // Returning false results in an INVALID_ACTION error, which translates to an error callback invoked on the JavaScript side
      // All other errors should be handled with the fail callback (callbackContext.error)
      // @see https://cordova.apache.org/docs/en/latest/guide/platforms/android/plugin.html
      return false;
    }

    return true;
  }


  /**
   * This method will add watermark to a video and will save to destination
   *
   * @param callbackContext A Cordova callback context
   * @param data JSON Array
   * @return uri to processed video
   */
  private boolean addWatermarkToVideo(CallbackContext callbackContext, JSONArray data) {
    Log.d(TAG, "addWatermarkToVideo: addWatermarkToVideo entered.");


	callbackContext.success(args.getString(0));


    // if (!validateData(data)) {
    //   callbackContext.error("REMOVE_INVALID_DATA");
    //   Log.d(TAG, "WifiWizard2: remove data invalid");
    //   return false;
    // }


  }


}
