package it.vrscuola.scuola.adapters;

import android.os.Handler;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.util.List;

import it.vrscuola.scuola.R;

public class MenuDialogAdapter extends RecyclerView.Adapter<MenuDialogAdapter.MenuViewHolder> {

    private List<String> menuItems;

    public MenuDialogAdapter(List<String> menuItems) {
        this.menuItems = menuItems;
    }

    @NonNull
    @Override
    public MenuViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_menu, parent, false);
        return new MenuViewHolder(view);
    }

    @Override
    public int getItemCount() {
        return menuItems.size();
    }

    @Override
    public void onBindViewHolder(@NonNull final MenuViewHolder holder, int position) {
        String menuItem = menuItems.get(position);
        animateText(holder.menuItemTextView, menuItem);
    }

    private void animateText(final TextView textView, final String text) {
        final int delay = 100; // Ritardo tra l'aggiunta di ciascuna lettera (in millisecondi)
        final Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            int count = 0;

            @Override
            public void run() {
                textView.setText(text.substring(0, count++));
                if (count <= text.length()) {
                    handler.postDelayed(this, delay);
                }
            }
        }, delay);
    }

    static class MenuViewHolder extends RecyclerView.ViewHolder {
        TextView menuItemTextView;

        MenuViewHolder(@NonNull View itemView) {
            super(itemView);
            menuItemTextView = itemView.findViewById(R.id.menuItemTextView);
        }
    }
}