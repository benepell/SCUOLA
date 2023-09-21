/**
 * Copyright (c) 2023, Benedetto Pellerito
 * Email: benedettopellerito@gmail.com
 * GitHub: https://github.com/benepell
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package it.vrscuola.scuola.ui.webviev;

import android.content.Context;
import android.content.res.Configuration;
import android.util.DisplayMetrics;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import it.vrscuola.scuola.utility.Constants;

public class CustomWebViewClient extends WebViewClient {

    private Context context;

    public CustomWebViewClient(Context context) {
        this.context = context;
    }

    @Override
    public void onPageFinished(WebView view, String url) {
        super.onPageFinished(view, url);

        if (url.equals(Constants.base)) {
            int scale;
            if (context.getResources().getConfiguration().orientation == Configuration.ORIENTATION_LANDSCAPE) {
                scale = calculateScaleForLandscape() + 30;
            } else {
                scale = calculateScaleForPortrait() * 3;
            }
            view.setInitialScale(scale);
        } else {
            int scale;
            if (context.getResources().getConfiguration().orientation == Configuration.ORIENTATION_LANDSCAPE) {
                scale = calculateScaleForLandscape();
            } else {
                scale = calculateScaleForPortrait();
            }
            view.setInitialScale(scale);
        }
    }

    private int calculateScaleForLandscape() {
        DisplayMetrics displayMetrics = context.getResources().getDisplayMetrics();
        int scale_l;

        if (displayMetrics.widthPixels > 2560) {
            scale_l = 160;
        } else if (displayMetrics.widthPixels > 1920 && displayMetrics.widthPixels <= 2560) {
            scale_l = 140;
        } else {
            scale_l = 120;
        }

        return scale_l;
    }

    private int calculateScaleForPortrait() {
        DisplayMetrics displayMetrics = context.getResources().getDisplayMetrics();
        int scale_p;

        if (displayMetrics.widthPixels > 2560) {
            scale_p = 110;
        } else if (displayMetrics.widthPixels > 1920 && displayMetrics.widthPixels <= 2560) {
            scale_p = 100;
        } else {
            scale_p = 90;
        }

        return scale_p;
    }
}
