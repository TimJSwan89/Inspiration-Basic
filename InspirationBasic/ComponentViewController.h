//
//  StatementComponentViewController.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/18/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Statement.h"
#import "HardcodeIntViewController.h"

@protocol ElementAccepter
- (void) acceptElement:(id) element;
@end

@interface ComponentViewController : UITableViewController<IntAccepter>

@property (nonatomic) id element;
@property (nonatomic) int type;
@property (nonatomic) id <ElementAccepter> delegate;

- (void) acceptInt:(int)integer;

@end
