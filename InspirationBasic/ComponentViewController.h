//
//  StatementComponentViewController.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/18/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HardcodeIntViewController.h"
#import "VariableViewController.h"
#import "ViewSettings.h"

@protocol SpecificScopeFinder
- (NSMutableArray *) getScope:(int)type;
@end

@protocol ElementAccepter
- (void) acceptElement:(id) element;
@end

@interface ComponentViewController : UITableViewController<IntAccepter, VarAccepter, ScopeFinder, HasBackButton>

//@property (nonatomic) id element;
@property (nonatomic) long type;
@property (nonatomic) id <ElementAccepter, SpecificScopeFinder> delegate;
@property ViewSettings * settings;
@property NSString * currentValueIfApplicable;
- (void) acceptInt:(int)integer;
- (void) acceptVar:(NSString *)variable;
- (NSMutableArray *) getScope;

+ (NSString *)defaultVar;

@end
