//
//  FMAccountDemo.h
//  Demo
//
//  Created by Kyle Balogh on 1/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FMDAccountViewController : UIViewController {
    UILabel *welcomeLabel;
    NSString *welcomeString;
}

@property (nonatomic, retain) IBOutlet UILabel *welcomeLabel;
@property (nonatomic, retain) NSString *welcomeString;

@end
