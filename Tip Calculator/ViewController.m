//
//  ViewController.m
//  Tip Calculator
//
//  Created by Kamal Maged on 2019-01-19.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentageTextField;
@property (weak, nonatomic) IBOutlet UISlider *tipPercentageSlider;
- (void) calculateTip;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   [[NSNotificationCenter defaultCenter]
     addObserver:self
    selector:@selector(keyboard:)
     name:UIKeyboardWillShowNotification
    object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(textFieldUpdated:)
     name:UITextFieldTextDidChangeNotification
     object:nil];
    
    
    [self.tipPercentageSlider setContinuous:YES];
    [self.tipPercentageSlider addTarget:self action:@selector(sliderUpdate:) forControlEvents:UIControlEventValueChanged];
}

- (void) keyboard: (NSNotification *)notification {
    NSDictionary * keyboardInfo = [notification userInfo];
    CGRect keyboardSize = [[keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self.view setFrame: CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, (self.view.frame.size.height) - keyboardSize.size.height)];
     
}
- (void) textFieldUpdated: (NSNotification *)notification {
    [self calculateTip];
}
- (void) sliderUpdate: (UISlider *) sender {
     [self calculateTip];
}

- (IBAction)calculateTip:(id)sender {

    [self calculateTip];
}
- (IBAction)adjustTipPercentage:(id)sender {
    
    
    self.tipPercentageTextField.text = @(self.tipPercentageSlider.value).stringValue;
    NSLog(@"%f", self.tipPercentageSlider.value);
}
- (void) calculateTip {
    self.tipAmountLabel.text = @(self.billAmountTextField.text.floatValue * self.tipPercentageTextField.text.floatValue / 100).stringValue;
}
@end
