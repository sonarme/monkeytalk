//
//  WebViewController.m
//  Demo
//
//  Created by Henry Harris on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebViewController.h"


@implementation WebViewController

@synthesize webView = _webView;
@synthesize helpButton; 

#pragma mark * Setup

- (void)loadInfoContent
{
    NSURL *infoFileURL = [[NSBundle mainBundle] URLForResource:@"web" withExtension:@"html"];
    assert(infoFileURL != nil);
    NSLog(@"url: %@",infoFileURL);

    [self.webView loadRequest:[NSURLRequest requestWithURL:infoFileURL]];
}

#pragma mark * View controller boilerplate

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadInfoContent];
    
    helpButton.accessibilityIdentifier = @"help";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.webView = nil;
}

- (IBAction)helpPressed:(id)sender{
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Web" message:@"MonkeyTalk can automate embedded UIWebViews including Inputs, TextAreas, DropDowns, Radio Buttons, Checkboxes, and more. UIWebView recoding coming soon..." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil] autorelease];
    
    [alert show];
    
}

@end