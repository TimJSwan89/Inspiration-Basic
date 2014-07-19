//
//  StatementViewController.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/1/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Program.h"

@interface ElementViewController : UITableViewController

@property (nonatomic) id element;
@property (nonatomic) int type;
@property NSMutableArray * typesIndex;
@property NSMutableArray * types;
@property NSMutableArray * elements;
@property NSMutableArray * strings;

- (void) initCellModels;

@end
