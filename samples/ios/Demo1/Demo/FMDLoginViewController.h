//
//  FMDemoLogin.h
//  Demo
//
//  Created by Kyle Balogh on 1/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FMDLoginViewController : UIViewController<UITextFieldDelegate> {
    UITextField *userField;
    UITextField *passField;
    UILabel *errorLabel;
    UIButton *loginButton;
    UIButton *helpButton; 
}

@property (nonatomic, retain) IBOutlet UITextField *userField;
@property (nonatomic, retain) IBOutlet UITextField *passField;
@property (nonatomic, retain) IBOutlet UILabel *errorLabel;
@property (nonatomic, retain) IBOutlet UIButton *loginButton;
@property (nonatomic, retain) IBOutlet UIButton *helpButton;


- (IBAction) loginPressed:(id)sender;

-(IBAction)helpPressed: (id) sender;

@end
