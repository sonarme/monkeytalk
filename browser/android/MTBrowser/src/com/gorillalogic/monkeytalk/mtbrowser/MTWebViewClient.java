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

import android.graphics.Bitmap;
import android.webkit.WebView;
import android.webkit.WebViewClient;
//import android.widget.Toast;

public class MTWebViewClient extends WebViewClient {
	@Override
    public boolean shouldOverrideUrlLoading(WebView view, String url) {
        view.loadUrl(url);
        return true;
    }

	@Override
	public void onPageFinished(WebView view, String url) {
		// TODO Auto-generated method stub
		super.onPageFinished(view, url);
//		Toast.makeText(view.getContext(), "finished loading", Toast.LENGTH_SHORT).show();
		
		this.updateUrlToolbar(view, false, url);
		this.updateNavToolbar((MTNavToolbar) view.getRootView().findViewById(R.id.nav_toolbar));
	}

	@Override
	public void onPageStarted(WebView view, String url, Bitmap favicon) {
		// TODO Auto-generated method stub
		super.onPageStarted(view, url, favicon);
//		Toast.makeText(view.getContext(), "started loading", Toast.LENGTH_SHORT).show();
		
		this.updateUrlToolbar(view, true, url);
		this.updateNavToolbar((MTNavToolbar) view.getRootView().findViewById(R.id.nav_toolbar));
	}
	
	private void updateUrlToolbar(WebView view, Boolean isLoading, String url) {
//		MTUrlToolbar urlToolbar = new MTUrlToolbar();
//		urlToolbar.updateUrlToolbar(view.getContext(), view, isLoading, url);
//		urlToolbar.finish();
		
		MTUrlToolbar urlToolbar = (MTUrlToolbar) view.getRootView().findViewById(R.id.url_toolbar);
		urlToolbar.updateUrlToolbar(view.getContext(), view, isLoading, url);
	}
	
	private void updateNavToolbar(MTNavToolbar navToolBar) {
//		MTUrlToolbar urlToolbar = new MTUrlToolbar();
//		urlToolbar.updateUrlToolbar(view.getContext(), view, isLoading, url);
//		urlToolbar.finish();
		MTNavButtons navButtons = (MTNavButtons) navToolBar.findViewById(R.id.nav_buttons);
		
		navButtons.updateButtonState();
	}

	@Override
	public void onLoadResource(WebView view, String url) {
		// TODO Auto-generated method stub
		super.onLoadResource(view, url);
	}
}
