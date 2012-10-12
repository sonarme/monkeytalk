//
//  FMDFormViewController.h
//  Demo
//
//  Created by Kyle Balogh on 1/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FMDFormViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource> {
    UIPickerView *pickerView;
    NSArray *elementsArray;
    UISwitch *switcher;
    UILabel *switchLabel;
    UISegmentedControl *radios;
    UISlider *slider;
    UIButton *helpButton;
}

@property (nonatomic, retain) IBOutlet UIPickerView *pickerView;
@property (nonatomic, retain) NSArray *elementsArray;
@property (nonatomic, retain) IBOutlet UISwitch *switcher;
@property (nonatomic, retain) IBOutlet UILabel *switchLabel;
@property (nonatomic, retain) IBOutlet UISegmentedControl *radios;
@property (nonatomic, retain) IBOutlet UISlider *slider;
@property (nonatomic, retain) IBOutlet UIButton *helpButton;

- (IBAction) switchValueChanged:(id)sender;
- (IBAction) radioIndexChanged:(id)sender;
- (IBAction) sliderValueChanged:(id)sender;
- (IBAction) helpPressed:(id)sender;
- (void) updateLabel;

@end
