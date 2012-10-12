package com.gorillalogic.monkeytalk.demo1;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.TextView;
import android.widget.TextView.OnEditorActionListener;

public class LoginActivity extends Activity {
	public static final String USERNAME = "username";

	private TextView username;
	private TextView password;
	private TextView err;
	private Button loginBtn;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.login);

		username = (TextView) findViewById(R.id.login_usr);
		username.setOnEditorActionListener(new OnEditorActionListener() { 
			
			@Override
			public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
				Log.d("demo1", "Hi, i'm a user-defined handler");
				return false;
			}
		});
		password = (TextView) findViewById(R.id.login_pwd);
		err = (TextView) findViewById(R.id.login_err);
		loginBtn = (Button) findViewById(R.id.login_btn);

		err.setText("");

		loginBtn.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				if (username.getText().length() < 4) {
					err.setText(R.string.loginFailedUsernameTooShort);
				} else if (password.getText().length() < 4) {
					err.setText(R.string.loginFailedPasswordTooShort);
				} else {
					err.setText("");
					new LoginTask().execute();
				}
			}
		});
	}

	private class LoginTask extends AsyncTask<Void, Void, Void> {
		private ProgressDialog dialog;

		protected void onPreExecute() {
			dialog = new ProgressDialog(LoginActivity.this);
			dialog.setMessage(getString(R.string.loginSuccess));
			dialog.setIndeterminate(true);
			dialog.setCancelable(false);
			dialog.show();
		}

		protected Void doInBackground(Void... unused) {
			try {
				Thread.sleep(2500);
			} catch (InterruptedException ex) {
				// do nothing
			}
			return null;
		}

		protected void onProgressUpdate(Void... unused) {
		}

		protected void onPostExecute(Void unused) {
			dialog.dismiss();
			
			//store username as extra data on the intent
			String usernameTxt = username.getText().toString();
			Intent intent = new Intent(LoginActivity.this, LogoutActivity.class);
			intent.putExtra(USERNAME, usernameTxt);
			
			LoginActivity.this.startActivity(intent);
			username.setText("");
			password.setText("");
		}
	}
}
