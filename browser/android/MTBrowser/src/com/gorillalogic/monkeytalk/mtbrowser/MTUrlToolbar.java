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

import android.content.Context;
//import android.os.Handler;
import android.util.AttributeSet;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.Animation.AnimationListener;
import android.view.animation.TranslateAnimation;
import android.view.inputmethod.InputMethodManager;
import android.webkit.WebView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.TextView.OnEditorActionListener;

public class MTUrlToolbar extends LinearLayout {
	
	private int toolbarHeight;
	
	private int getToolbarHeight() {
		if (toolbarHeight == 0 && browserActivity().mUrlToolbar.getMeasuredHeight() > 0)
        	toolbarHeight = browserActivity().mUrlToolbar.getMeasuredHeight();
		
		return toolbarHeight;
	}

	public MTUrlToolbar(Context context, AttributeSet attrs) {
		super(context, attrs);
		// TODO Auto-generated constructor stub

	    LayoutInflater inflater = (LayoutInflater)context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        if(inflater != null){ 	
          inflater.inflate(R.layout.url_toolbar, this);        
        }
        
        // Set reload listener for reload button
        reloadButton().setOnClickListener(reloadButtonListener());
        
        urlField().setOnFocusChangeListener(urlFocusChanged());
        urlField().setOnEditorActionListener(new OnEditorActionListener() {

			public boolean onEditorAction(TextView v, int actionId,
					KeyEvent event) {
				// TODO Auto-generated method stub
				
				if (event != null && (event.getKeyCode() == KeyEvent.KEYCODE_ENTER)) {
					InputMethodManager inputManager = (InputMethodManager) v.getContext().getSystemService(Context.INPUT_METHOD_SERVICE);                       
	                inputManager.hideSoftInputFromWindow(v.getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS);                       
	                v.clearFocus();
	                
//	                WebView mtWebView = (WebView)v.getRootView().findViewById(R.id.mt_webview);
//	                mtWebView.loadUrl(v.getPrivateImeOptions().toString());
	                goToUrl(formattedUrl(v.getText().toString(), true));
				} 
				return false;
			}
	    });
        
        // Set monkeyIDs
        urlField().setContentDescription(context.getString(R.string.mtid_url_field));
        reloadButton().setContentDescription(context.getString(R.string.mtid_refresh));
        titleLabel().setContentDescription(context.getString(R.string.mtid_title));
        
        toolbarHeight = this.getMeasuredHeight();
        
//        this.urlField().setLayoutParams(new LinearLayout.LayoutParams(LayoutParams.FILL_PARENT, 70));
	}
	
	private OnFocusChangeListener urlFocusChanged() {
		return new OnFocusChangeListener() {

			public void onFocusChange(View v, boolean hasFocus) {
				// TODO Auto-generated method stub
				if (hasFocus)
					browserActivity().mCancelButton.setVisibility(View.VISIBLE);
				else
					browserActivity().mCancelButton.setVisibility(View.GONE);
			}
        };
	}
	
	void goToUrl(String url) {
		WebView mtWebView = (WebView)this.getRootView().findViewById(R.id.mt_webview);
		mtWebView.loadUrl(url);
	}
	
	private MTBrowserActivity browserActivity() {
		return (MTBrowserActivity) this.getRootView().getContext();
	}
	
	public EditText urlField() {
		return (EditText) findViewById(R.id.url_field);
	}
	
	private TextView titleLabel() {
		return (TextView) findViewById(R.id.title);
	}
	
	private Button reloadButton() {
		return (Button) findViewById(R.id.reload);
	}
	
	private OnClickListener reloadButtonListener() {
		return new OnClickListener() {
			public void onClick(View v) {
				// TODO Auto-generated method stub
				browserActivity().mWebView.reload();
			}
        };
	}
	
	public void updateUrlToolbar(Context context, WebView view, Boolean isLoading, String url) {
		
		// If webview url empty set url field to url string
//		try {
//			if (view.getUrl().length() > 0 && !isLoading)
//				this.urlTextView(context).setText(view.getUrl());
//			else
//				this.urlTextView(context).setText(url);
//		} catch (Exception e) {
//			this.urlTextView(context).setText(url);
//		}
		
		LinearLayout loadingContainer = (LinearLayout) this.findViewById(R.id.loading_container);
		
		if (!urlField().hasFocus())
			this.urlField().setText(formattedUrl(url, false));
		
		// Set title textview based on loading state
		if (isLoading == true) {
			loadingContainer.setVisibility(VISIBLE);
			this.titleLabel().setText(context.getString(R.string.loading_string));
		} else {
			loadingContainer.setVisibility(GONE);
			this.titleLabel().setText(view.getTitle());
		}
	}
	
	private String formattedUrl(String url, Boolean forRequest) {
		
		if (url.length() > 7) {
			if (!forRequest) {
				if (url.substring(0, 7).equalsIgnoreCase("http://")) {
					return url.substring(7);
				} else if (url.substring(0, 8).equalsIgnoreCase("https://"))
					return url.substring(8);
			} else {
				if (!url.substring(0, 7).equalsIgnoreCase("http://") &&
						!url.substring(0, 8).equalsIgnoreCase("https://") &&
						!url.substring(0, 7).equalsIgnoreCase("file://")) {
					return "http://" + url;
				}
			}
		}
		
		return url;
	}
	
	public void hide() {
		this.moveUrlToolbar(-getToolbarHeight());
	}
	
	public void show() {
		this.moveUrlToolbar(getToolbarHeight());
	}
	
	// TODO: Get animation to work -- returns early for now
	private void moveUrlToolbar(final int toPosition) {
		if (toPosition > 0 || toPosition <= 0)
			return;
		
		int padding = toPosition;
		if (toPosition == toolbarHeight)
			padding = 0;
		
		if (browserActivity().mUrlToolbar.getPaddingTop() != padding) {
			WebView mtWebView = (WebView) this.getRootView().findViewById(R.id.mt_webview);
			
			TranslateAnimation ta = new TranslateAnimation(0, 0, 0, toPosition);
	    	ta.setDuration(300);
	    	
	    	TranslateAnimation ta2 = new TranslateAnimation(0, 0, 0, toPosition);
	    	ta2.setDuration(300);
	    	
	    	ta.setFillAfter(true);
	    	mtWebView.startAnimation(ta2);
	    	
	    	 AnimationListener animListener = new AnimationListener() {
	    		 
				public void onAnimationEnd(Animation animation) {
					// TODO Auto-generated method stub
					int top = browserActivity().mUrlToolbar.getPaddingTop() + toPosition;
					
					if (toPosition == toolbarHeight)
						top = 0;
					
					browserActivity().mUrlToolbar.setPadding(browserActivity().mUrlToolbar.getPaddingLeft(), 
		        			top, 
		        			browserActivity().mUrlToolbar.getPaddingRight(), 
		        			browserActivity().mUrlToolbar.getPaddingBottom());
				}
				public void onAnimationRepeat(Animation animation) {
					// TODO Auto-generated method stub
					
				}
				public void onAnimationStart(Animation animation) {
					// TODO Auto-generated method stub
					
				}
	    	 };
	    	 
	    	 ta.setAnimationListener(animListener);
	    	 this.startAnimation(ta);
		}
	}
	
}
