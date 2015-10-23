//
//  HardcodeIntViewController.m
//  InspirationBasic
//
//  Created by Timothy Swan on 7/20/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "HardcodeIntViewController.h"

@interface HardcodeIntViewController ()

@end

@implementation HardcodeIntViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.settings setSettingsForView:self.view];
    [self.settings setSettingsForTextField:self.inputField];
    [self initialize];
    self.inputField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [self.inputField becomeFirstResponder];
    [self.inputField setText:self.initialValue];
    [self update];
    if (!self.doneButton.enabled)
        [self.inputField setText:@""];
    self.navigationItem.leftBarButtonItem = [self.settings getBackArrowWithReceiver:self];
}

-(void)popQuick {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initialize {
    [self update];
}

- (void) update {
    NSString * string = self.inputField.text;
    int value = [string intValue];
    NSString * intString = [NSString stringWithFormat:@"%d", value];
    bool equal = [string isEqualToString:intString];
    self.currentValue = value;
    [self.settings setFeedbackForTextField:self.inputField to:equal];
    [self.doneButton setEnabled:equal];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)fieldWasEdited:(UITextField *)sender {
    [self update];
}

- (IBAction)donePressed:(UIBarButtonItem *)sender {
    [self.doneButton setEnabled:false];
    [self.delegate acceptInt:self.currentValue];
}
@end
