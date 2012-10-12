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

#import "MTBNavigationView.h"
#import "MTBBrowserController.h"

@implementation MTBNavigationView
@synthesize back, forward;

static int PADDING = 25;
static int NAV_HEIGHT = 40;
static int BUTTON_SIZE = 20;

- (id) initWithBrowser:(MTBBrowserController *)bc {
    self = [super init];
    
    if (self){
        // Initialization code
        
        float yCenter = NAV_HEIGHT/2+1;
        float alpha = 0.9;
        float viewWidth = 0;
        
        back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BUTTON_SIZE, BUTTON_SIZE)];
        [back addTarget:bc action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        [back setImage:[UIImage imageNamed:@"mt_back.png"] forState:UIControlStateNormal];
        back.center = CGPointMake(back.center.x+PADDING, yCenter);
        back.alpha = alpha;
        
        forward = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BUTTON_SIZE, BUTTON_SIZE)];
        [forward addTarget:bc action:@selector(goForward) forControlEvents:UIControlEventTouchUpInside];
        [forward setImage:[UIImage imageNamed:@"mt_forward.png"] forState:UIControlStateNormal];
        forward.center = CGPointMake(back.center.x+back.frame.size.width+PADDING, 
                                     yCenter);
        forward.alpha = alpha;
        
        // Set accessibility label for MonkeyTalk
        back.accessibilityLabel = @"Back";
        forward.accessibilityLabel = @"Forward";
        
        // Disable buttons by default
        back.enabled = NO;
        forward.enabled = NO;
        
        viewWidth = forward.frame.origin.x + forward.frame.size.width + PADDING/2;
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, viewWidth, NAV_HEIGHT);
        
        [self addSubview:back];
        [self addSubview:forward];
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
