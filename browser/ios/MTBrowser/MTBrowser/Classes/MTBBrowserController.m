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

#import "MTBBrowserController.h"

@interface MTBBrowserController()
- (void) showTools;
- (void) updateButtonState;
@end

@implementation MTBBrowserController

static NSString *DEFAULT_URL = @"gorillalogic.com/testing-tools/monkeytalk";
static int TOOLBAR_HEIGHT = 40;

@synthesize webView, urlView, tools, webScrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.webView];
    [self showUrlView];
    [self showTools];
    
    self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth|
                                  UIViewAutoresizingFlexibleHeight|
                                  UIViewAutoresizingFlexibleTopMargin|
                                  UIViewAutoresizingFlexibleBottomMargin|
                                  UIViewAutoresizingFlexibleLeftMargin|
                                  UIViewAutoresizingFlexibleRightMargin);
    self.view.autoresizesSubviews = YES;
    
    for (UIView *view in [self.view subviews]) {
        if ([view isKindOfClass:[MTBUrlView class]])
            view.autoresizingMask = (UIViewAutoresizingFlexibleWidth|
                                     UIViewAutoresizingFlexibleLeftMargin|
                                     UIViewAutoresizingFlexibleRightMargin);
        else if ([view isKindOfClass:[UIWebView class]])
            view.autoresizingMask = (UIViewAutoresizingFlexibleHeight|
                                     UIViewAutoresizingFlexibleWidth|
                                     UIViewAutoresizingFlexibleLeftMargin|
                                     UIViewAutoresizingFlexibleRightMargin);
        else
            view.autoresizingMask = (UIViewAutoresizingFlexibleWidth|
                                      UIViewAutoresizingFlexibleTopMargin|
                                      UIViewAutoresizingFlexibleLeftMargin|
                                      UIViewAutoresizingFlexibleRightMargin);
//        view.autoresizesSubviews = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark - Handle WebView

- (UIWebView *) webView {
    if (!webView) {
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 
                                                              0, 
                                                              self.view.frame.size.width, 
                                                              self.view.frame.size.height)];
        webView.delegate = self;
        webView.scalesPageToFit = YES;
        [self goToUrl:DEFAULT_URL];
        
        // Find scrollview and add URL input view
        for (UIScrollView *scrollView in [webView subviews]) {
            NSString *classString = [NSString stringWithFormat:@"%@",scrollView.superclass];
            
            if ([classString isEqualToString:@"UIWebScrollView"]) {
                
                for (UIView *browserView in [scrollView subviews]) {
                    classString = [NSString stringWithFormat:@"%@",[browserView class]];
                    
                    // Find the Browser View and resize/reposition it
                    if ([classString isEqualToString:@"UIWebBrowserView"]) {
                        browserView.frame = CGRectMake(browserView.frame.origin.x, 
                                                       browserView.frame.origin.y+urlView.frame.size.height, 
                                                       browserView.frame.size.width, 
                                                       browserView.frame.size.height-urlView.frame.size.height);
                        scrollView.contentSize = CGSizeMake(scrollView.contentSize.width, 
                                                            scrollView.contentSize.height + urlView.frame.size.height);
                        scrollView.delegate = self;
                        webScrollView = scrollView;
                        
                        break;
                    }
                }
                
                break;
            }
        }
    }
    
    return webView;
}

- (void) goToUrl:(NSString *)urlString {
    if ([urlString length] < 7 ||
        (![[[urlString substringToIndex:7] lowercaseString] isEqualToString:@"file://"] &&
         ![[[urlString substringToIndex:7] lowercaseString] isEqualToString:@"http://"] &&
         ![[[urlString substringToIndex:8] lowercaseString] isEqualToString:@"https://"]))
        urlString = [NSString stringWithFormat:@"http://%@",urlString];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

- (NSString *) urlForField {
    NSString *urlString = [NSString stringWithFormat:@"%@",webView.request.URL];
    
    if ([urlString length] >= 7 && 
        [[[urlString substringToIndex:7] lowercaseString] isEqualToString:@"http://"])
        urlString = [urlString substringFromIndex:7];
    else if ([urlString length] >= 8 && 
             [[[urlString substringToIndex:8] lowercaseString] isEqualToString:@"https://"])
        urlString = [urlString substringFromIndex:8];
    else if ([urlString length] >= 7 && 
             [[[urlString substringToIndex:7] lowercaseString] isEqualToString:@"file://"])
        urlString = urlString;
    else
        urlString = urlView.urlField.text;
    
    return urlString;
}

- (void) reloadUrl {
    if (urlView.urlField.isFirstResponder)
        [urlView.urlField resignFirstResponder];
    
    [self goToUrl:[NSString stringWithFormat:@"%@",webView.request.URL]];
}

- (void) goBack {
    [webView goBack];
    urlView.urlField.text = [self urlForField];
//    [webScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
}

- (void) goForward {
    [webView goForward];
    [webScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
}

- (void) webViewDidStartLoad:(UIWebView *)webView {
    // If there is not already an activity view, show one
    if ([[urlView.urlField.leftView subviews] count] == 0) {
        [urlView showLoadingActivity];
        [self showUrlView];
        urlView.titleLabel.text = @"Loading";
    }
}

- (void) webViewDidFinishLoad:(UIWebView *)aWebView {
    if (!urlView.urlField.isEditing)
        urlView.urlField.text = [self urlForField];
    
    urlView.titleLabel.text = [webView 
                               stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self updateButtonState];
    
    [urlView hideLoadingActivity];
}

- (void) webView:(UIWebView *)aWebView didFailLoadWithError:(NSError *)error {
    NSString *errorString = [[error userInfo] objectForKey:@"NSLocalizedDescription"];
    
    if ([errorString length] > 0) {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Cannot Open Page" 
                                                             message:errorString 
                                                            delegate:nil 
                                                   cancelButtonTitle:nil 
                                                   otherButtonTitles:@"OK", nil];
        [errorAlert show];
        [urlView hideLoadingActivity];
        urlView.titleLabel.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
}

#pragma mark - Handle ScrollView in WebView

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // Do not hide url view when urlfield becomes first responder
    if (urlView.urlField.isFirstResponder)
        return;
    
    if (scrollView.contentOffset.y > 1 && 
        webView.frame.origin.y == urlView.frame.size.height) {
        if (urlView) {
            [urlView animateHide];
        }
    } else if (scrollView.contentOffset.y <= 1 && webView.frame.origin.y == 0) {
        [self showUrlView];
    }
}

#pragma mark - Handle Toolbars

- (void) showTools {
    // Do not show toolbar on iPad
    if (UI_USER_INTERFACE_IDIOM()) {
        webView.frame = CGRectMake(webView.frame.origin.x, 
                                   webView.frame.origin.y, 
                                   webView.frame.size.width, 
                                   webView.frame.size.height-urlView.frame.size.height);
        return;
    }
    
    if (!tools) {
        tools = [[MTBToolsView alloc] initWithFrame:CGRectMake(0, 
                                                               self.view.frame.size.height-TOOLBAR_HEIGHT, 
                                                               self.view.frame.size.width, TOOLBAR_HEIGHT) 
                                        withBrowser:self];
        
        // Add URL input view
        [self.view addSubview:tools];
        [self updateButtonState];
        
        webView.frame = CGRectMake(webView.frame.origin.x, 
                                   webView.frame.origin.y, 
                                   webView.frame.size.width, 
                                   webView.frame.size.height - tools.frame.size.height);
    }
}

- (void) updateButtonState {
    MTBNavigationView *navView = tools.navView;
    
    // Target url navView if iPad
    if (UI_USER_INTERFACE_IDIOM())
        navView = urlView.navView;
    
    if (webView.canGoBack)
        navView.back.enabled = YES;
    else
        navView.back.enabled = NO;
    
    if (webView.canGoForward)
        navView.forward.enabled = YES;
    else
        navView.forward.enabled = NO;
}

#pragma mark - Show URL View
- (void) showUrlView {
    if (!urlView) {
        urlView = [[MTBUrlView alloc] initWithWidth:self.view.frame.size.width andBrowser:self];
        urlView.urlField.text = DEFAULT_URL;
        
        // Add URL input view
        [self.view addSubview:urlView];
        
        webView.frame = CGRectMake(webView.frame.origin.x, 
                                      urlView.frame.size.height, 
                                      webView.frame.size.width, 
                                      webView.frame.size.height);
    } else
        [urlView animateShow];
}

@end
