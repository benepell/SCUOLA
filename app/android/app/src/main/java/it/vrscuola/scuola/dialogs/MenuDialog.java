package it.vrscuola.scuola.dialogs;

import android.app.AlertDialog;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;

import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import java.util.List;

import it.vrscuola.scuola.R;
import it.vrscuola.scuola.adapters.MenuDialogAdapter;

public class MenuDialog {

    public static void showMenuDialog(Context context, List<String> menuItems) {
        AlertDialog.Builder builder = new AlertDialog.Builder(context);
        LayoutInflater inflater = LayoutInflater.from(context);
        View dialogView = inflater.inflate(R.layout.dialog_menu_layout, null);

        RecyclerView menuRecyclerView = dialogView.findViewById(R.id.menuRecyclerView);
        menuRecyclerView.setLayoutManager(new LinearLayoutManager(context));
        MenuDialogAdapter adapter = new MenuDialogAdapter(menuItems);
        menuRecyclerView.setAdapter(adapter);

        builder.setView(dialogView);
        AlertDialog dialog = builder.create();
        dialog.show();
    }
}
