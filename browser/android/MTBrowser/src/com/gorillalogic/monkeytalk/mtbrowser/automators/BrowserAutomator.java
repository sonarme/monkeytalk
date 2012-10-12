package com.gorillalogic.monkeytalk.mtbrowser.automators;

import com.gorillalogic.fonemonkey.automators.AutomatorBase;
import com.gorillalogic.monkeytalk.mtbrowser.MTBrowserActivity;

public class BrowserAutomator extends AutomatorBase {

	@Override
	public String getComponentType() {
		return "Browser";
	}

	@Override
	public String play(String action, String... args) {
		if (action.equalsIgnoreCase("open")) {
			assertArgCount("Open", args, 1);
			MTBrowserActivity.open(args[0]);
			return "";
		}
		
		if (action.equalsIgnoreCase("back")) {
			MTBrowserActivity.back();
			return "";
		}
		
		if (action.equalsIgnoreCase("forward")) {
			MTBrowserActivity.forward();
			return "";
		}		
		return super.play(action, args);
	}
	
	

}
