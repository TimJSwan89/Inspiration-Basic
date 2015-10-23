//
//  HardcodeIntViewController.h
//  InspirationBasic
//
//  Created by Timothy Swan on 7/20/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewSettings.h"

@protocol IntAccepter
- (void) acceptInt:(int)integer;
@end

@interface HardcodeIntViewController : UIViewController<HasBackButton>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (strong, nonatomic) IBOutlet UITextField *inputField;
@property (nonatomic) id<IntAccepter> delegate;
@property ViewSettings * settings;
@property (nonatomic) int currentValue;
@property NSString * initialValue;
- (IBAction)fieldWasEdited:(UITextField *)sender;
- (IBAction)donePressed:(UIBarButtonItem *)sender;
@end

