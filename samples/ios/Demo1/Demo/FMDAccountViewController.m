//
//  FMAccountDemo.m
//  Demo
//
//  Created by Kyle Balogh on 1/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FMDAccountViewController.h"

@interface FMDAccountViewController()
- (void) logout;
@end

@implementation FMDAccountViewController

@synthesize welcomeLabel, welcomeString;

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
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    welcomeLabel.text = welcomeString;
    
    UIBarButtonItem *logoutButton = [[[UIBarButtonItem alloc] 
                                      initWithTitle:@"LOGOUT" 
                                      style:UIBarButtonItemStyleBordered 
                                      target:self 
                                      action:@selector(logout)] 
                                     autorelease];
    
    self.navigationItem.title = @"Welcome";
    self.navigationItem.rightBarButtonItem = logoutButton;
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

- (void) logout {
    [self dismissModalViewControllerAnimated:YES];
}

@end
