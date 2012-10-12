//
//  FMDDetailsViewController.h
//  Demo
//
//  Created by Kyle Balogh on 1/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDElement.h"


@interface FMDDetailsViewController : UIViewController {
    FMDElement *element;
    
    UILabel *numberLabel;
    UILabel *symbolLabel;
    UILabel *nameLabel;
}

@property (nonatomic, retain) FMDElement *element;

@property (nonatomic, retain) IBOutlet UILabel *numberLabel;
@property (nonatomic, retain) IBOutlet UILabel *symbolLabel;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;

@end
