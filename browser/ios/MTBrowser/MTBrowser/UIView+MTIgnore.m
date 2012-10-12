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

#import "UIView+MTIgnore.h"
#import "MTBUrlView.h"
#import "MTBNavigationView.h"
#import "MTBToolsView.h"

@implementation UIWindow (MTIgnore)
- (BOOL) isMTEnabled {
    return NO;
}
@end

@implementation UIView (MTIgnore)
- (BOOL) isMTEnabled {
    return NO;
}
@end

@implementation UITextField (MTIgnore)
- (BOOL) isMTEnabled {
    return NO;
}
@end

@implementation UIButton (MTIgnore)
- (BOOL) isMTEnabled {
    return NO;
}
@end

@implementation MTBUrlView (MTIgnore)
- (BOOL) isMTEnabled {
    return NO;
}
@end

@implementation MTBNavigationView (MTIgnore)
- (BOOL) isMTEnabled {
    return NO;
}
@end

@implementation MTBToolsView (MTIgnore)
- (BOOL) isMTEnabled {
    return NO;
}
@end