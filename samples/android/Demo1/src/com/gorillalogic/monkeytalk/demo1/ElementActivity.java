package com.gorillalogic.monkeytalk.demo1;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

public class ElementActivity extends Activity {
	public static final String ELEMENT = "element";
	public static final String SYMBOL = "symbol";
	public static final String ATOMIC_NUMBER = "atomic_number";

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.element);

		TextView element = (TextView) findViewById(R.id.element_name);
		TextView symbol = (TextView) findViewById(R.id.element_symb);
		TextView atomicNumber = (TextView) findViewById(R.id.element_num);

		element.setText(getIntent().getStringExtra(ELEMENT));
		symbol.setText(getIntent().getStringExtra(SYMBOL));
		atomicNumber.setText(Integer.toString(getIntent().getIntExtra(ATOMIC_NUMBER, 0)));
	}
}
