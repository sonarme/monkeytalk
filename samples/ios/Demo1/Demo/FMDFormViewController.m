//
//  FMDFormViewController.m
//  Demo
//
//  Created by Kyle Balogh on 1/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FMDFormViewController.h"


@implementation FMDFormViewController

@synthesize pickerView, elementsArray, switcher, switchLabel, radios, slider, helpButton;

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
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    
    NSString* dataPlist = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Data.plist"];
    
    elementsArray = [[NSDictionary dictionaryWithContentsOfFile:dataPlist] objectForKey:@"Elements"];
    
    [elementsArray retain];

    radios.accessibilityIdentifier = @"myRadios";
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

#pragma mark - Picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return 10;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[elementsArray objectAtIndex:row] objectForKey:@"Name"];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"select: %@",[[elementsArray objectAtIndex:row] objectForKey:@"Name"]);
    [self updateLabel];
}

#pragma mark - Slider
- (IBAction) sliderValueChanged:(id)sender {
    slider.value = round(slider.value);
    [self updateLabel];
}

#pragma mark - Switch
- (IBAction) switchValueChanged:(id)sender {
    [self updateLabel];
}
            
#pragma mark - Radio
- (IBAction) radioIndexChanged:(id)sender {
    [self updateLabel];
}

#pragma mark - Help
- (IBAction)helpPressed:(id)sender{
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Forms" message:@"MonkeyTalk can automate UIPickerViews, UISwitches, UISegmentedControls, UISliders, and more."delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
    [alert show]; 
}

#pragma mark - Updater
- (void) updateLabel {
    switchLabel.text = [NSString stringWithFormat:@"%@ | %@ | %@ | %@", [[elementsArray objectAtIndex:[pickerView selectedRowInComponent:0]] objectForKey:@"Name"], (switcher.isOn ? @"on" : @"off"), [radios titleForSegmentAtIndex: [radios selectedSegmentIndex]], [NSString stringWithFormat:@"%0.0f", slider.value]];
}

@end
