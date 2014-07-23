//
//  StatementViewController.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/1/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Program.h"
#import "ComponentViewController.h"

@protocol Reloadable
- (void) reload;
@end

@interface ElementViewController : UITableViewController<ElementAccepter, Reloadable>

@property (nonatomic) id element;
@property (nonatomic) int type;
@property NSMutableArray * typesIndex;
@property NSMutableArray * types;
@property NSMutableArray * elements;
@property NSMutableArray * strings;
@property (nonatomic) id <ElementAccepter, Reloadable> delegate;

- (void) initCellModels;
- (void) reload;

@end
