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

@interface OutputViewController : UIViewController<OutputListener>
@property ViewSettings * settings;
@property (strong, nonatomic) IBOutlet UITextView * outputTextView;
@property (nonatomic, strong) NSString * outputText;
@property (nonatomic) Program * program;
@end
