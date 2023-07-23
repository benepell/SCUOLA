package it.vrscuola.scuola;

import android.content.Intent;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.view.MenuItem;
import android.view.View;
import android.view.Menu;
import android.view.ViewGroup;
import android.view.Window;
import android.webkit.WebView;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AlertDialog;
import androidx.core.view.GravityCompat;
import androidx.navigation.NavController;
import androidx.navigation.Navigation;
import androidx.navigation.ui.AppBarConfiguration;
import androidx.navigation.ui.NavigationUI;

import com.google.android.material.navigation.NavigationView;

import androidx.drawerlayout.widget.DrawerLayout;
import androidx.appcompat.app.AppCompatActivity;

import java.util.ArrayList;
import java.util.List;

import it.vrscuola.scuola.databinding.ActivityMainBinding;
import it.vrscuola.scuola.ui.webviev.CustomWebViewClient;
import it.vrscuola.scuola.utility.Constants;

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
        webView.getSettings().setJavaScriptEnabled(true);
        webView.setWebViewClient(new CustomWebViewClient(MainActivity.this));

       // webView.getSettings().setUserAgentString(Constants.userAgent);
        webView.loadUrl(Constants.base);

        setSupportActionBar(binding.appBarMain.toolbar);

        DrawerLayout drawer = binding.drawerLayout;
        NavigationView navigationView = binding.navView;

        mAppBarConfiguration = new AppBarConfiguration.Builder(
                R.id.nav_home, R.id.nav_classe, R.id.nav_visori, R.id.nav_risorse, R.id.nav_utenti, R.id.nav_diagnosi, R.id.nav_logout)
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
                boolean inBrowser = false;

                if (id == R.id.nav_home) {
                    url = Constants.base;
                } else if (id == R.id.nav_classe) {
                    url = Constants.base.concat("abilita-classe");
                } else if (id == R.id.nav_visori) {
                    url = Constants.base.concat("setup-visore");
                } else if (id == R.id.nav_risorse) {
                    url = Constants.risorse;
                    inBrowser = true;
                } else if (id == R.id.nav_utenti) {
                    url = Constants.utenti;
                } else if (id == R.id.nav_diagnosi) {
                    url = Constants.base.concat("diagnosi");
                } else if (id == R.id.nav_logout) {
                    url = Constants.base.concat("logout");
                }

                if (!url.isEmpty()) {
                    if (inBrowser) {
                        // Apri il link "risorse" nel browser
                        Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
                        startActivity(intent);
                    } else {
                        webView.loadUrl(url);
                    }

                }

                drawer.closeDrawer(GravityCompat.START);
                return true;
            }
        });
    }
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int itemId = item.getItemId();
        if (itemId == R.id.action_settings) {

            List<String> menuItems = new ArrayList<>();
            menuItems.add(Constants.credits_1);
            menuItems.add(Constants.credits_2);
            menuItems.add(Constants.credits_3);

            final ArrayAdapter<String> adapter = new ArrayAdapter<String>(MainActivity.this, android.R.layout.simple_list_item_1, menuItems) {
                @NonNull
                @Override
                public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
                    View view = super.getView(position, convertView, parent);
                    TextView textView = (TextView) view.findViewById(android.R.id.text1);
                    textView.setTextSize(24f);
                    textView.setTextColor(Color.GREEN);

                    if (position == 0) { // Applica l'effetto solo alla terza riga
                        final String text = getItem(position);
                        if (text != null && !text.isEmpty()) {
                            textView.setText(""); // Rimuovi il testo iniziale per l'animazione
                            animateText(textView, text);
                        }
                    }

                    return view;
                }
            };

            final AlertDialog dialog = new AlertDialog.Builder(MainActivity.this)
                    .setTitle("Menu")
                    .setAdapter(adapter, null)
                    .show();

            Window window = dialog.getWindow();
            if (window != null) {
                window.setBackgroundDrawable(new ColorDrawable(Color.parseColor("#80000000")));
            }

            new Handler().postDelayed(new Runnable() {
                @Override
                public void run() {
                    // Chiudi la finestra dopo 3 secondi
                    if (dialog != null && dialog.isShowing()) {
                        dialog.dismiss();
                    }
                }
            }, Constants.timeout);

            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    private void animateText(final TextView textView, final String text) {
        final Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            int index = 0;

            @Override
            public void run() {
                textView.setText(text.substring(0, index++));
                if (index <= text.length()) {
                    handler.postDelayed(this, Constants.postDelay);
                }
            }
        }, Constants.delayTimeout);
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

}
