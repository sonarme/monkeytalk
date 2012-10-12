//
//  WebViewController.h
//  Demo
//
//  Created by Henry Harris on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate> {
    
    IBOutlet UIWebView *webView;
    IBOutlet UIButton *helpButton;
    
    
}

@property (nonatomic, retain)UIWebView *webView;
@property (nonatomic,retain)UIButton *helpButton;


- (IBAction)helpPressed:(id)sender;




@end
