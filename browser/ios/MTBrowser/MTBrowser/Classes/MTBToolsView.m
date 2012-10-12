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

#import "MTBToolsView.h"
#import "MTBBrowserController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+MTBrowser.h"

@implementation MTBToolsView
@synthesize navView;


- (id)initWithFrame:(CGRect)frame withBrowser:(MTBBrowserController *)bc
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mt_dark_texture.png"]];
        
        // Create border
        UIView *border = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 2)];
        border.backgroundColor = [UIColor gorillaOrange];
        
        border.autoresizingMask = (UIViewAutoresizingFlexibleWidth|
                                         UIViewAutoresizingFlexibleTopMargin|
                                         UIViewAutoresizingFlexibleLeftMargin|
                                         UIViewAutoresizingFlexibleRightMargin);
        
        navView = [[MTBNavigationView alloc] initWithBrowser:bc];
        
        [self addSubview:navView];
        [self addSubview:border];
        
//        [self addSubview:toolBar];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
