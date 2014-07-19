//
//  StatementComponentViewController.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/18/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Statement.h"

@interface ComponentViewController : UITableViewController

@property (nonatomic) id <Statement> statement;

@end
