//
//  OutputViewController.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/15/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "OutputViewController.h"
#include <stdlib.h>
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
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Background processing
        @autoreleasepool {
            [self.program executeWithListener:self];
        }
    });
}

- (void) postOutput:(NSString *)string {
    dispatch_async( dispatch_get_main_queue(), ^{
        NSLog(@"->%f",self.outputTextView.contentOffset.y);
        self.outputText = [self.outputText stringByAppendingString:string];
        if (self.outputText.length > 100)
            self.outputText = [self.outputText substringFromIndex:self.outputText.length - 100];
        //[self.outputTextView setScrollEnabled:NO];
        [self.outputTextView setText:self.outputText];
        NSLog(@"\"%@\"",self.outputTextView.text);
        CGPoint bottomOffset = CGPointMake(0, self.outputTextView.contentSize.height - self.outputTextView.bounds.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height);
        //NSLog(@"\nheightView: %f \nheightBoundsSize: %f \noffset: %f",self.outputTextView.contentSize.height,self.outputTextView.bounds.size.height,bottomOffset.y);
        [self.outputTextView setScrollEnabled:YES];
        [self.outputTextView setContentOffset:bottomOffset animated:NO];
        NSLog(@"  %f",bottomOffset.y);
    });
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
