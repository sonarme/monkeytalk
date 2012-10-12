package com.gorillalogic.monkeytalk.demo1;

import android.app.TabActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.TabHost;
import android.widget.TabHost.TabSpec;
import android.widget.TabWidget;
import android.widget.TextView;

public class RootActivity extends TabActivity {

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.root);

		TabHost tabHost = getTabHost();
		TabSpec spec;
		View indicator;

		spec = tabHost.newTabSpec("login");
		indicator = LayoutInflater.from(this).inflate(R.layout.tab_layout, getTabWidget(), false);
		((TextView) indicator.findViewById(R.id.tab_txt)).setText("login");
		((ImageView) indicator.findViewById(R.id.tab_img)).setImageResource(R.drawable.icon_login);
		spec.setIndicator(indicator);
		spec.setContent(new Intent(this, LoginActivity.class));
		tabHost.addTab(spec);

		spec = tabHost.newTabSpec("forms");
		indicator = LayoutInflater.from(this).inflate(R.layout.tab_layout, getTabWidget(), false);
		((TextView) indicator.findViewById(R.id.tab_txt)).setText("forms");
		((ImageView) indicator.findViewById(R.id.tab_img)).setImageResource(R.drawable.icon_forms);
		spec.setIndicator(indicator);
		spec.setContent(new Intent(this, FormsActivity.class));
		tabHost.addTab(spec);

		spec = tabHost.newTabSpec("hierarchy");
		indicator = LayoutInflater.from(this).inflate(R.layout.tab_layout, getTabWidget(), false);
		((TextView) indicator.findViewById(R.id.tab_txt)).setText("hierarchy");
		((ImageView) indicator.findViewById(R.id.tab_img))
				.setImageResource(R.drawable.icon_hierarchy);
		spec.setIndicator(indicator);
		spec.setContent(new Intent(this, HierarchyActivity.class));
		tabHost.addTab(spec);

		spec = tabHost.newTabSpec("web");
		indicator = LayoutInflater.from(this).inflate(R.layout.tab_layout, getTabWidget(), false);
		((TextView) indicator.findViewById(R.id.tab_txt)).setText("web");
		((ImageView) indicator.findViewById(R.id.tab_img)).setImageResource(R.drawable.icon_web);
		spec.setIndicator(indicator);
		spec.setContent(new Intent(this, WebActivity.class));
		tabHost.addTab(spec);

		tabHost.setCurrentTab(0);

		TabWidget tabWidget = getTabWidget();
		for (int i = 0; i < tabWidget.getChildCount(); i++) {
			View v = tabWidget.getChildAt(i);
			v.setBackgroundDrawable(getResources().getDrawable(R.drawable.tab_selector));
		}
	}
}
