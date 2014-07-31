//
//  OutputViewController.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/15/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "OutputViewController.h"

@interface OutputViewController ()

@end

@implementation OutputViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.outputText = @"";
    [self.outputTextView setText:self.outputText];
    [self.settings setSettingsForTextView:self.outputTextView];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.program executeWithListener:self];
}

//- (void) runProgram {
//    [self.program executeWithListener:self];
//}

- (void) postOutput:(NSString *)string {
    self.outputText = [self.outputText stringByAppendingString:string];
    [self.outputTextView setText:self.outputText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

@end
