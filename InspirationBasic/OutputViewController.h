//
//  OutputViewController.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/15/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Program.h"
#import "ViewSettings.h"
#import "EnvironmentModel.h"
@protocol ExecutionDelegate
- (void) finishedExecuting;
@end
@interface OutputViewController : UIViewController<OutputListener, HasBackButton>
@property ViewSettings * settings;
@property (strong, nonatomic) IBOutlet UITextView * outputTextView;
@property (nonatomic, strong) NSString * outputText;
@property (nonatomic) Program * program;
@property (weak, nonatomic) id<ExecutionDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *pauseButton;
- (IBAction)stopButtonPressed:(UIBarButtonItem *)sender;
@property bool stopped;
@property EnvironmentModel * environment;
@property (atomic) int numberOfPosts;
@end
