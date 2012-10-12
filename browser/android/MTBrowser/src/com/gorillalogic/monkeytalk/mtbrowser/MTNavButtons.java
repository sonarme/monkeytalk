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
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;

public class MTNavButtons extends LinearLayout {

	public MTNavButtons(Context context, AttributeSet attrs) {
		super(context, attrs);
		// TODO Auto-generated constructor stub
		
		LayoutInflater inflater = (LayoutInflater)context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        if(inflater != null){ 	
          inflater.inflate(R.layout.nav_buttons, this);        
        }
        
        OnClickListener buttonListenter = buttonListener();
        
        back().setOnClickListener(buttonListenter);
        forward().setOnClickListener(buttonListenter);
        
        // Set monkeyIDs
        back().setContentDescription(context.getString(R.string.mtid_back));
        forward().setContentDescription(context.getString(R.string.mtid_forward));
	}
	
	private MTBrowserActivity browserActivity() {
		return (MTBrowserActivity) this.getRootView().getContext();
	}
	
	private Button back() {
		return (Button) findViewById(R.id.back);
	}
	
	private Button forward() {
		return (Button) findViewById(R.id.forward);
	}
	
	private OnClickListener buttonListener() {
		return new OnClickListener() {
			public void onClick(View v) {
				// TODO Auto-generated method stub
				
				if (v.getId() == R.id.back) {
//					Toast.makeText(getContext(), "clicked back", Toast.LENGTH_SHORT).show();
					if (browserActivity().mWebView.canGoBack())
						browserActivity().mWebView.goBack();
				} else {
//					Toast.makeText(getContext(), "clicked forward", Toast.LENGTH_SHORT).show();
					if (browserActivity().mWebView.canGoForward())
						browserActivity().mWebView.goForward();
				}
			}
        };
	}
	
	public void updateButtonState() {
		back().setEnabled(browserActivity().mWebView.canGoBack());
		forward().setEnabled(browserActivity().mWebView.canGoForward());
	}

}
