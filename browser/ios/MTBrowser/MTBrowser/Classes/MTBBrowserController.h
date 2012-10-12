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

#import <UIKit/UIKit.h>
#import "MTBUrlView.h"
#import "MTBToolsView.h"
#import "MTBNavigationView.h"

@interface MTBBrowserController : UIViewController<UIWebViewDelegate,UIScrollViewDelegate,UITextFieldDelegate> {
    UIWebView *webView;
    MTBUrlView *urlView;
    MTBToolsView *tools;
    UIScrollView *webScrollView;
    
}

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) MTBUrlView *urlView;
@property (nonatomic, strong) MTBToolsView *tools;
@property (nonatomic, strong) UIScrollView *webScrollView;

- (void) goToUrl:(NSString *)urlString;
- (NSString *) urlForField;
- (void) reloadUrl;
- (void) goBack;
- (void) goForward;
- (void) showUrlView;

@end
