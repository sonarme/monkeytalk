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

#import "MTBUrlView.h"
#import <QuartzCore/QuartzCore.h>
#import "MTBBrowserController.h"
#import "UIColor+MTBrowser.h"

@interface MTBUrlView() {
    MTBBrowserController *bc;
}
@property(nonatomic, strong) MTBBrowserController *bc;
- (void) keyboardDidHide:(id)sender;
@end

@implementation MTBUrlView
@synthesize urlField, titleLabel, navView, bc;
static int URL_HEIGHT = 30;
static int URL_PADDING = 24;
static int TOOLBAR_HEIGHT = 50;
static int TITLE_HEIGHT = 14;
static int FIELD_PADDING = 8;
static int REFRESH_WIDTH = 26;
static int REFRESH_HEIGHT = 18;

- (id) initWithWidth:(float)width andBrowser:(id)browser {
    self = [super init];
    
    if (self) {
        bc = browser;
        self.frame = CGRectMake(0, 0, width, TOOLBAR_HEIGHT+TITLE_HEIGHT);
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mt_dark_texture.png"]];
        
        // Call keyboardDidHide: when keyboard hidden with iPad key
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardDidHide:)
                                                     name:UIKeyboardDidHideNotification
                                                   object:nil];
        
        // Create border
        UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-2, self.frame.size.width, 2)];
        bottomBorder.backgroundColor = [UIColor gorillaOrange];
        
        bottomBorder.autoresizingMask = (UIViewAutoresizingFlexibleWidth|
                                         UIViewAutoresizingFlexibleTopMargin|
                                         UIViewAutoresizingFlexibleLeftMargin|
                                         UIViewAutoresizingFlexibleRightMargin);
        
        [self addSubview:self.urlField];
        
        // If iPad — show nav view in url bar
        if (UI_USER_INTERFACE_IDIOM()){
            navView = [[MTBNavigationView alloc] initWithBrowser:bc];
            urlField.frame = CGRectMake(urlField.frame.origin.x+navView.frame.size.width, 
                                        urlField.frame.origin.y, 
                                        urlField.frame.size.width-navView.frame.size.width, 
                                        urlField.frame.size.height);
            navView.center = CGPointMake(navView.center.x, urlField.center.y);
            [self addSubview:navView];
        }
        
        [self addSubview:self.titleLabel];
        [self addSubview:bottomBorder];
    }
    
    return self;
}

- (UITextField *) urlField {
    if (!urlField) {
        // Setup url field
        urlField = [[UITextField alloc] initWithFrame:CGRectMake(0, TITLE_HEIGHT+FIELD_PADDING, self.frame.size.width-URL_PADDING, URL_HEIGHT)];
        urlField.textColor = [UIColor darkGrayColor];
        urlField.borderStyle = UITextBorderStyleLine;
        urlField.keyboardAppearance = UIKeyboardAppearanceAlert;
        urlField.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
        urlField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        urlField.placeholder = @"Go to this address";
        urlField.returnKeyType = UIReturnKeyGo;
        urlField.enablesReturnKeyAutomatically = YES;
        urlField.keyboardType = UIKeyboardTypeURL;
        urlField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        urlField.autocorrectionType = UITextAutocorrectionTypeNo;
        urlField.clearButtonMode = UITextFieldViewModeWhileEditing;
        urlField.delegate = self;
        urlField.accessibilityLabel = @"URL";
        urlField.autoresizingMask = (UIViewAutoresizingFlexibleWidth|
                                 UIViewAutoresizingFlexibleTopMargin|
                                 UIViewAutoresizingFlexibleRightMargin);
        
        // Add refresh button to right view
        UIButton *refreshButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 
                                                                             0, 
                                                                             REFRESH_WIDTH, 
                                                                             REFRESH_HEIGHT)];
        [refreshButton setImage:[UIImage imageNamed:@"mt_reload.png"] forState:UIControlStateNormal];
        [refreshButton setImage:[UIImage imageNamed:@"mt_reload_selected.png"] forState:UIControlStateHighlighted];
        refreshButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, FIELD_PADDING);
        [refreshButton addTarget:bc action:@selector(reloadUrl) forControlEvents:UIControlEventTouchUpInside];
        urlField.rightView = refreshButton;
        urlField.rightViewMode = UITextFieldViewModeUnlessEditing;
        
        // Set accessibility label for MonkeyTalk
        refreshButton.accessibilityLabel = @"Refresh";
        
        // Add padding to the text field
        UIView *leftPadding = [[UIView alloc] initWithFrame:CGRectMake(0, 
                                                                       0, 
                                                                       FIELD_PADDING, 
                                                                       urlField.frame.size.height)];
        urlField.leftView = leftPadding;
        urlField.leftViewMode = UITextFieldViewModeAlways;
        
        // Center url field
        urlField.center = CGPointMake(self.center.x, urlField.center.y);
    }
    
    return urlField;
}

- (UILabel *) titleLabel {
    if (!titleLabel) {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.frame.size.width-4, TITLE_HEIGHT)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.center = CGPointMake(self.center.x, titleLabel.center.y);
        titleLabel.textAlignment = UITextAlignmentCenter;
        titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
        titleLabel.textColor = [UIColor colorWithWhite:1 alpha:0.7];
        
        // Set accessibility label for MonkeyTalk
        titleLabel.accessibilityLabel = @"Title";
        
        titleLabel.autoresizingMask = (UIViewAutoresizingFlexibleWidth|
                                       UIViewAutoresizingFlexibleTopMargin|
                                       UIViewAutoresizingFlexibleLeftMargin|
                                       UIViewAutoresizingFlexibleRightMargin);
    }
    
    return titleLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) cancelInput:(id)sender {
    UIButton *cancelButton = (UIButton *)sender;
    
    // Hide keyboard
    if ([urlField isFirstResponder])
        [urlField resignFirstResponder];
    
    // Change URL field text if cancelled
    if (cancelButton.tag != 11)
        urlField.text = [bc urlForField];
    
    [UIView animateWithDuration:0.2 animations:^{
        cancelButton.alpha = 0;
    }completion:^(BOOL finished){
        [cancelButton removeFromSuperview];
    }];
}

#pragma mark - TextField delegate methods

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    float width = bc.view.frame.size.width;
    
    if (bc.interfaceOrientation == UIDeviceOrientationLandscapeLeft ||
        bc.interfaceOrientation == UIDeviceOrientationLandscapeRight)
        width = bc.view.frame.size.height;
    
    UIButton *cancelButton = [[UIButton alloc] 
                              initWithFrame:CGRectMake(0, 
                                                       self.frame.size.height, 
                                                       width, 
                                                       bc.view.frame.size.height - self.frame.size.height)];
    [cancelButton addTarget:self 
                     action:@selector(cancelInput:) forControlEvents:UIControlEventTouchDown];
    cancelButton.backgroundColor = [UIColor blackColor];
    cancelButton.alpha = 0;
    
    // Fade cancel button in
    [UIView animateWithDuration:0.2 animations:^{
        cancelButton.alpha = 0.4;
    }];
    
    // Set accessibility label for MonkeyTalk
    cancelButton.accessibilityLabel = @"Cancel";
    
    [bc.view addSubview:cancelButton];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    NSString *urlString = textField.text;
    
    for (UIButton *button in [bc.view subviews]) {
        if ([button.accessibilityLabel isEqualToString:@"Cancel"]) {
            button.tag = 11;
            [self cancelInput:button];
            break;
        }
    }
    
    [bc goToUrl:urlString];
    [textField resignFirstResponder];
    return YES;
}

- (void) keyboardDidHide:(id)sender {
    for (UIButton *button in [bc.view subviews]) {
        if ([button.accessibilityLabel isEqualToString:@"Cancel"]) {
            [self cancelInput:button];
            break;
        }
    }
}

#pragma mark - Loading Indicator
- (void) showLoadingActivity {
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activity startAnimating];
    urlField.leftView.frame = CGRectMake(urlField.leftView.frame.origin.x, 
                                                 urlField.leftView.frame.origin.y, 
                                                 activity.frame.size.width+10, 
                                                 urlField.leftView.frame.size.height);
    activity.center = CGPointMake(urlField.leftView.frame.size.width/2+2, 
                                  urlField.leftView.frame.size.height/2);
    [urlField.leftView addSubview:activity];
}

- (void) hideLoadingActivity {
    for (UIView *view in [urlField.leftView subviews])
        [view removeFromSuperview];
    
    urlField.leftView.frame = CGRectMake(urlField.leftView.frame.origin.x, 
                                                 urlField.leftView.frame.origin.y, 
                                                 FIELD_PADDING, 
                                                 urlField.leftView.frame.size.height);
}

#pragma mark - Show/Hide View

- (void) animateShow {
    
    [UIView animateWithDuration:0.3 animations:^{
        bc.webView.frame = CGRectMake(bc.webView.frame.origin.x, 
                                   self.frame.size.height, 
                                   bc.webView.frame.size.width, 
                                   bc.webView.frame.size.height);
        
        self.center = CGPointMake(self.center.x, self.frame.size.height/2);
    } completion:^(BOOL finished){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            // Wait until done dragging and done bouncing before setting webView size
            while (bc.webScrollView.isDragging)
                usleep(100);
            
            [NSThread sleepForTimeInterval:0.4];
            
            // If the url view is still visible, resize the webview
            if (self.frame.origin.y >= 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    float height = bc.view.frame.size.height - self.frame.size.height - bc.tools.frame.size.height;
                    
                    if (bc.interfaceOrientation == UIInterfaceOrientationLandscapeRight ||
                        bc.interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
                        height = bc.view.frame.size.width - self.frame.size.height - bc.tools.frame.size.height;
                    }
                    
                    bc.webView.frame = CGRectMake(bc.webView.frame.origin.x, 
                                                  bc.webView.frame.origin.y, 
                                                  bc.webView.frame.size.width, 
                                                  height);
                }); 
            }
        });
    }];
}

- (void) animateHide {
    // Do not hide url view on iPad
    if (UI_USER_INTERFACE_IDIOM())
        return;
    
    float height = bc.view.frame.size.height - bc.tools.frame.size.height;
    
    if (bc.interfaceOrientation == UIInterfaceOrientationLandscapeRight ||
        bc.interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        height = bc.view.frame.size.width - bc.tools.frame.size.height;
    }
    
//    NSLog(@"animateHide: %f",height);
    
    bc.webView.frame = CGRectMake(bc.webView.frame.origin.x, 
                                          bc.webView.frame.origin.y, 
                                          bc.webView.frame.size.width, 
                                          height);
    
    [UIView animateWithDuration:0.3 animations:^{
        bc.webView.frame = CGRectMake(bc.webView.frame.origin.x, 
                                   0, 
                                   bc.webView.frame.size.width, 
                                   bc.webView.frame.size.height);
        
        self.center = CGPointMake(self.center.x, -self.frame.size.height/2);
    }];
}

@end
