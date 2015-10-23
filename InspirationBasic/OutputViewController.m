//
//  OutputViewController.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/15/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "OutputViewController.h"
#include <stdlib.h>
#import "ProgramException.h"
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
    self.outputTextView.editable = NO;
    self.outputTextView.scrollEnabled = YES;
    //self.outputTextView.textContainer.maximumNumberOfLines = 10;
    self.environment = [[EnvironmentModel alloc] initWithOutputListener:self];
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.stopped = false;
        self.pauseButton.enabled = true;
        self.numberOfPosts = 0;
        [self.program executeAgainst:self.environment];
        [self postOutput:@"Finished executing."];
        self.stopped = true;
        //self.pauseButton.enabled = false;
        [self.pauseButton setStyle:UIBarButtonItemStyleDone];
        dispatch_async( dispatch_get_main_queue(), ^{
            [self.delegate finishedExecuting];
        });
    });
    
    self.navigationItem.leftBarButtonItem = [self.settings getBackArrowWithReceiver:self];
}

-(void)popQuick {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.settings setSettingsForTextView:self.outputTextView];
}

- (void) postOutput:(NSString *)string {
    self.outputText = [self.outputText stringByAppendingString:string];
    if (self.outputText.length > 1000)
        self.outputText = [self.outputText substringFromIndex:self.outputText.length - 1000];
    self.numberOfPosts++;
    while (self.numberOfPosts > 1) {
        usleep(1);
    }
    dispatch_async( dispatch_get_main_queue(), ^{
        //NSLog(@"->%f",self.outputTextView.contentOffset.y);
        [self.outputTextView setScrollEnabled:NO];
        [self.outputTextView setText:self.outputText];
        //NSLog(@"\"%@\"",self.outputTextView.text);
        CGPoint bottomOffset;
        #define isiPhone5  ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE
        if (isiPhone5)
        {
            bottomOffset = CGPointMake(0, self.outputTextView.contentSize.height - self.outputTextView.bounds.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height);
        }
        else
        {
            //self.outputTextView.contentSize = CGSizeMake(scrollView.frame.size.width, sizeOfContent);
            bottomOffset = CGPointMake(0, self.outputTextView.contentSize.height - self.outputTextView.bounds.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height);
        }
        //NSLog(@"\nheightView: %f \nheightBoundsSize: %f \noffset: %f",self.outputTextView.contentSize.height,self.outputTextView.bounds.size.height,bottomOffset.y);
        [self.outputTextView setScrollEnabled:YES];
        [self.outputTextView setContentOffset:bottomOffset animated:NO];
        //NSLog(@"  %f",bottomOffset.y);
        self.numberOfPosts--;
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

- (IBAction)stopButtonPressed:(UIBarButtonItem *)sender {
    self.stopped = true;
    self.pauseButton.enabled = false;
    self.environment.exception = [[ProgramException alloc] initWithMessage:@"User stopped execution."];
}

@end
