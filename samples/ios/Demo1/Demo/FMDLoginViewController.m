//
//  FMDemoLogin.m
//  Demo
//
//  Created by Kyle Balogh on 1/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FMDLoginViewController.h"
#import "FMDAccountViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface FMDLoginViewController()
- (void) showAccountView;
- (NSString *) verifyUserPass;

@end

@implementation FMDLoginViewController


@synthesize userField, passField, errorLabel, loginButton, helpButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    [self.navigationController setNavigationBarHidden:YES];

    helpButton.accessibilityIdentifier = @"help";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) resetLoginFields {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:0.33];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            userField.text = @"";
            passField.text = @"";
        }); 
    });
}

- (void) loginPressed:(id)sender {
    if (![self verifyUserPass]) {
        [self showAccountView];
        errorLabel.text = @"";
    }
    else
        errorLabel.text = [NSString 
                           stringWithFormat:@"Sorry! %@ must be 4 or more characters.",
                           [self verifyUserPass]];
}

- (void) helpPressed: (id)sender {
    
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Login" message:@"MonkeyTalk can automate UITextFields, UIButtons, UILabels, and more." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
    // optional - add more buttons:
    [alert show];
    
}

- (void) showAccountView {
    loginButton.enabled = NO;
    FMDAccountViewController *account = [[FMDAccountViewController alloc] 
                                         initWithNibName:@"FMDAccountViewController" 
                                         bundle:nil];
    
    account.welcomeString = [NSString 
                             stringWithFormat:@"Welcome, %@!",
                             userField.text];
    
    UINavigationController *navController = [[UINavigationController alloc] 
                                             initWithRootViewController:account];
    
    UIView *loadingView = [[UIView alloc] 
                           initWithFrame:CGRectMake(self.view.frame.size.width/2-90, 
                                                    self.view.frame.size.height/2-30, 
                                                    180, 
                                                    60)];
    loadingView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    loadingView.layer.cornerRadius = 8;
    
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] 
                                         initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activity.frame = CGRectMake(loadingView.frame.size.width/2-80, 
                                loadingView.frame.size.height/2-activity.frame.size.height/2, 
                                activity.frame.size.width, 
                                activity.frame.size.height);
    [activity startAnimating];
    
    UILabel *loggingIn = [[UILabel alloc] initWithFrame:CGRectMake(20 + activity.frame.size.width, 0, 180, 60)];
    loggingIn.text = @"Logging in...";
    loggingIn.backgroundColor = [UIColor clearColor];
    loggingIn.textColor = [UIColor whiteColor];
    
    [loadingView addSubview:activity];
    [loadingView addSubview:loggingIn];
    
    [self.view addSubview:loadingView];
    
    if ([userField isFirstResponder])
        [userField resignFirstResponder];
    else
        [passField resignFirstResponder];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:2.5];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.33 animations:^(void){
                loadingView.alpha = 0;
            }completion:^(BOOL finished){
                [loadingView release];
                loginButton.enabled = YES;
            }];
            
            [self resetLoginFields];
            
            [self presentModalViewController:navController animated:NO];
        }); 
    });
}

- (NSString *) verifyUserPass {
    if ([userField.text length] < 4) {
        return @"Username";
    } else if ([passField.text length] < 4) {
        return @"Password";
    }
    
    return nil;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void) keyboardDone:(id)sender {
    if ([userField isFirstResponder])
        [userField resignFirstResponder];
    else
        [passField resignFirstResponder];
}

@end
