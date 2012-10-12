/*  MTBrowser - a simple browser with a MonkeyTalk test target
    Copyright (C) 2012 Gorilla Logic, Inc.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>. */

package com.gorillalogic.monkeytalk.mtbrowser;

import com.gorillalogic.monkeytalk.mtbrowser.R;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.view.MotionEvent;
import android.view.View;
import android.view.Window;
import android.view.View.OnClickListener;
import android.view.inputmethod.InputMethodManager;
import android.webkit.WebView;
import android.widget.Button;

public class MTBrowserActivity extends Activity {
    /** Called when the activity is first created. */
	private static MTBrowserActivity instance;
	public WebView mWebView;
	public MTUrlToolbar mUrlToolbar;
	public MTNavToolbar mNavToolbar;
	public Button mCancelButton;
	
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.main);
             
        mWebView = (WebView) findViewById(R.id.mt_webview);
        mUrlToolbar = (MTUrlToolbar) findViewById(R.id.url_toolbar);
        mNavToolbar = (MTNavToolbar) findViewById(R.id.nav_toolbar);
        mCancelButton = (Button) findViewById(R.id.cancel_button);
        mCancelButton.setOnClickListener(cancelButtonListener());
        
        // Setup webview
        mWebView.getSettings().setLoadWithOverviewMode(true);
        mWebView.getSettings().setUseWideViewPort(true);
        mWebView.setWebViewClient(new MTWebViewClient());
        mWebView.getSettings().setJavaScriptEnabled(true);
        mWebView.loadUrl(getString(R.string.default_url));
        
        // Set monkeyIDs
        mCancelButton.setContentDescription(getString(R.string.mtid_cancel));
        mWebView.getSettings().setBuiltInZoomControls(true);  
        instance = this;
    }	
    
    public static void open(String url) {
    	instance.mUrlToolbar.goToUrl(url);
    }
    
    private OnClickListener cancelButtonListener() {
		return new OnClickListener() {
			public void onClick(View v) {
				// TODO Auto-generated method stub
				InputMethodManager inputManager = (InputMethodManager) v.getContext().getSystemService(Context.INPUT_METHOD_SERVICE);                       
                inputManager.hideSoftInputFromWindow(v.getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS); 
                
				mUrlToolbar.urlField().clearFocus();
				v.setVisibility(View.GONE);
			}
        };
	}
    
    // Show/hide url toolbar based on webview scrollY position
    public boolean onTouchEvent(final MotionEvent event) {
        if (event.getAction() == MotionEvent.ACTION_MOVE) {
            int yPos = mWebView.getScrollY();
            
            if (yPos == 0) {
            	mUrlToolbar.show();
            } else if (mUrlToolbar.getPaddingTop() == 0) {
            	mUrlToolbar.hide();
            }
        }
        return false;
    }

	public static void back() {
		instance.mWebView.goBack();
	}
	
	public static void forward() {
		instance.mWebView.goForward();
	}
}