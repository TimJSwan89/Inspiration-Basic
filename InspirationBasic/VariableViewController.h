//
//  VariableViewController.h
//  InspirationBasic
//
//  Created by Timothy Swan on 7/20/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewSettings.h"

@protocol ScopeFinder
- (NSMutableArray *) getScope;
@end

@protocol VarAccepter
- (void) acceptVar:(NSString *)variable;
@end

@interface VariableViewController : UITableViewController

@property (nonatomic) id<ScopeFinder, VarAccepter> delegate;
@property ViewSettings * settings;
@property (nonatomic) UITextField * textField;
@property (nonatomic) UIButton * button;

@property (nonatomic) NSMutableArray * variables;

- (IBAction)edited:(UITextField *)sender;
- (IBAction)pressedUse:(UIButton *)sender;

@end
