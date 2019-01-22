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
    selector:@selector(keyboardWillShow:)
     name:UIKeyboardWillShowNotification
    object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(keyboardWillHide:)
     name:UIKeyboardWillHideNotification
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(textFieldUpdated:)
     name:UITextFieldTextDidChangeNotification
     object:nil];
    
    
    [self.tipPercentageSlider setContinuous:YES];
    [self.tipPercentageSlider addTarget:self action:@selector(sliderUpdate:) forControlEvents:UIControlEventValueChanged];
    
    self.billAmountTextField.delegate = self;
    self.tipPercentageTextField.delegate = self;
    
   
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void) keyboardWillShow: (NSNotification *)notification {
    NSDictionary * keyboardInfo = [notification userInfo];
    CGRect keyboardSize = [[keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (self.view.bounds.origin.y == 0) {
        self.view.bounds = CGRectOffset(self.view.bounds, 0, keyboardSize.size.height);
    }
    
}
- (void) keyboardWillHide: (NSNotification *)notification {
    NSDictionary * keyboardInfo = [notification userInfo];
    CGRect keyboardSize = [[keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (self.view.bounds.origin.y !=0) {
        self.view.bounds = CGRectOffset(self.view.bounds, 0, -keyboardSize.size.height);
    }
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
