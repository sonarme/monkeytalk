package com.gorillalogic.monkeytalk.demo1;

import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

public class HierarchyActivity extends ListActivity {
	private String[] symbols;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.hierarchy);

		setListAdapter(ArrayAdapter.createFromResource(this, R.array.theElements,
				android.R.layout.simple_list_item_1));

		symbols = getResources().getStringArray(R.array.theElementSymbols);
	}

	@Override
	protected void onListItemClick(ListView l, View v, int position, long id) {
		super.onListItemClick(l, v, position, id);

		// Get the item that was clicked
		String element = this.getListAdapter().getItem(position).toString();
		String symbol = symbols[position];
		int num = position + 1;
		Log.d("ItemClick", element + " symb=" + symbol + " num=" + num);

		Intent intent = new Intent(this, ElementActivity.class);
		intent.putExtra(ElementActivity.ELEMENT, element);
		intent.putExtra(ElementActivity.SYMBOL, symbol);
		intent.putExtra(ElementActivity.ATOMIC_NUMBER, num);

		startActivity(intent);
	}
}
