package it.vrscuola.scuola;

import android.content.res.Configuration;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.os.Handler;
import android.util.DisplayMetrics;
import android.view.MenuItem;
import android.view.View;
import android.view.Menu;
import android.view.ViewGroup;
import android.view.Window;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.ArrayAdapter;
import android.widget.ListView;
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
import com.google.android.material.snackbar.Snackbar;

import androidx.drawerlayout.widget.DrawerLayout;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;

import java.util.ArrayList;
import java.util.List;

import it.vrscuola.scuola.databinding.ActivityMainBinding;
import it.vrscuola.scuola.dialogs.MenuDialog;

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
        DisplayMetrics displayMetrics = getResources().getDisplayMetrics();
        int scale_p, scale_l;

        if (displayMetrics.widthPixels > 2560) {
            scale_l = 180;
            scale_p = 110;
        } else if (displayMetrics.widthPixels > 1920 && displayMetrics.widthPixels <= 2560) {
            scale_l = 160;
            scale_p = 100;
        } else {
            scale_l = 140;
            scale_p = 90;
        }

        if (getResources().getConfiguration().orientation == Configuration.ORIENTATION_LANDSCAPE) {
            webView.setInitialScale(scale_l);
        } else {
            webView.setInitialScale(scale_p);
        }
        webView.getSettings().setUserAgentString("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4644.0 Safari/537.36");
        webView.loadUrl("https://scuola.vrscuola.it");

        setSupportActionBar(binding.appBarMain.toolbar);

        DrawerLayout drawer = binding.drawerLayout;
        NavigationView navigationView = binding.navView;
        // Passing each menu ID as a set of Ids because each
        // menu should be considered as top level destinations.

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

                if (id == R.id.nav_home) {
                    url = "https://scuola.vrscuola.it";
                } else if (id == R.id.nav_classe) {
                    url = "https://scuola.vrscuola.it/abilita-classe";
                } else if (id == R.id.nav_visori) {
                    url = "https://scuola.vrscuola.it/setup-visore";
                } else if (id == R.id.nav_risorse) {
                    url = "https://scuola.vrscuola.it:8443/";
                } else if (id == R.id.nav_utenti) {
                    url = "https://keycloak.vrscuola.it:9443/admin/master/console/#/scuola/users";
                } else if (id == R.id.nav_diagnosi) {
                    url = "https://scuola.vrscuola.it/diagnosi";
                } else if (id == R.id.nav_logout) {
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
    public boolean onOptionsItemSelected(MenuItem item) {
        int itemId = item.getItemId();
        if (itemId == R.id.action_settings) {
            // Logica da eseguire quando viene premuto l'elemento "action_settings"
            List<String> menuItems = new ArrayList<>();
            menuItems.add("Autore: Benedetto Pellerito");
            menuItems.add("Software per la didattica VrScuola");
            menuItems.add("© 2023 Tutti i diritti riservati");

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
            }, 5000); // 3000 millisecondi = 3 secondi

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
                    handler.postDelayed(this, 100); // Delay di 100 millisecondi tra ogni carattere
                }
            }
        }, 150); // Delay iniziale di 100 millisecondi
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
