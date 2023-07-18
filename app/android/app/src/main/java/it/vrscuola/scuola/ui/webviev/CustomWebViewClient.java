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
