package it.vrscuola.scuola;

import android.content.res.Configuration;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.MenuItem;
import android.view.View;
import android.view.Menu;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import androidx.annotation.NonNull;
import androidx.core.view.GravityCompat;
import androidx.navigation.NavController;
import androidx.navigation.Navigation;
import androidx.navigation.ui.AppBarConfiguration;
import androidx.navigation.ui.NavigationUI;

import com.google.android.material.navigation.NavigationView;
import com.google.android.material.snackbar.Snackbar;

import androidx.drawerlayout.widget.DrawerLayout;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;

import it.vrscuola.scuola.databinding.ActivityMainBinding;

public class MainActivity extends AppCompatActivity {

    private AppBarConfiguration mAppBarConfiguration;
    private ActivityMainBinding binding;

    private WebView webView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = ActivityMainBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        webView = findViewById(R.id.webview);
        webView.setWebViewClient(new WebViewClient());
        webView.getSettings().setJavaScriptEnabled(true);
        int scale = 80;
        if (getResources().getConfiguration().orientation == Configuration.ORIENTATION_LANDSCAPE) {
            webView.setInitialScale(scale*2);
        } else {
            webView.setInitialScale(scale);
        }
        webView.getSettings().setUserAgentString("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4644.0 Safari/537.36");
        webView.loadUrl("https://scuola.vrscuola.it");

        setSupportActionBar(binding.appBarMain.toolbar);

        DrawerLayout drawer = binding.drawerLayout;
        NavigationView navigationView = binding.navView;
        // Passing each menu ID as a set of Ids because each
        // menu should be considered as top level destinations.
        mAppBarConfiguration = new AppBarConfiguration.Builder(
                R.id.nav_home, R.id.nav_classe, R.id.nav_visori, R.id.nav_risorse, R.id.nav_utenti, R.id.nav_diagnosi)
                .setOpenableLayout(drawer)
                .build();

        NavController navController = Navigation.findNavController(this, R.id.nav_host_fragment_content_main);
        NavigationUI.setupActionBarWithNavController(this, navController, mAppBarConfiguration);
        NavigationUI.setupWithNavController(navigationView, navController);

        navigationView.setNavigationItemSelectedListener(new NavigationView.OnNavigationItemSelectedListener() {
            @Override
            public boolean onNavigationItemSelected(@NonNull MenuItem item) {
                // Handle navigation view item clicks here.
                int id = item.getItemId();

                String url = "";

                if (id == R.id.nav_home) {
                    url = "https://scuola.vrscuola.it";
                } else if (id == R.id.nav_classe) {
                    url = "https://scuola.vrscuola.it/abilita-classe";
                }else if (id == R.id.nav_visori) {
                    url = "https://scuola.vrscuola.it/setup-visore";
                }else if (id == R.id.nav_risorse) {
                    url = "https://scuola.vrscuola.it:8443/";
                }
                else if (id == R.id.nav_utenti) {
                    url = "https://keycloak.vrscuola.it:9443/admin/master/console/#/scuola/users";
                }
                else if (id == R.id.nav_diagnosi) {
                    url = "https://scuola.vrscuola.it/diagnosi";
                }else if (id == R.id.nav_logout) {
                    url = "https://scuola.vrscuola.it/logout";
                }

                // Aggiungi altre condizioni per le altre voci del menu

                if (!url.isEmpty()) {
                    webView.loadUrl(url);
                }

                drawer.closeDrawer(GravityCompat.START);
                return true;
            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    @Override
    public boolean onSupportNavigateUp() {
        NavController navController = Navigation.findNavController(this, R.id.nav_host_fragment_content_main);
        return NavigationUI.navigateUp(navController, mAppBarConfiguration)
                || super.onSupportNavigateUp();
    }

    private float getScaleFactorForLandscape() {
        DisplayMetrics displayMetrics = getResources().getDisplayMetrics();
        float deviceWidth = displayMetrics.widthPixels;
        float scaleFactor = deviceWidth / 1080; // Adatta il fattore di scala in base alla larghezza dello schermo desiderata (1080 in questo caso)
        return scaleFactor;
    }

    private float getScaleFactorForPortrait() {
        DisplayMetrics displayMetrics = getResources().getDisplayMetrics();
        float deviceWidth = displayMetrics.widthPixels;
        float scaleFactor = deviceWidth / 720; // Adatta il fattore di scala in base alla larghezza dello schermo desiderata (720 in questo caso)
        return scaleFactor;
    }
}
