package com.gorillalogic.monkeytalk.demo1;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.TextView;

public class LogoutActivity extends Activity {
	private TextView welcome;
	private Button logoutBtn;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.logout);

		welcome = (TextView) findViewById(R.id.logout_txt);
		logoutBtn = (Button) findViewById(R.id.logout_btn);

		String username = getIntent().getStringExtra(LoginActivity.USERNAME);
		String welcomeTxt = getString(R.string.logoutWelcome, username);
		welcome.setText(welcomeTxt);

		logoutBtn.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				LogoutActivity.this.finish();
			}
		});
	}
	
	@Override
	public void onBackPressed() {
		// do nothing
	}
}
