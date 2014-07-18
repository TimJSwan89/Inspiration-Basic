//
//  BoolExpressionViewController.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/18/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoolExpression.h"

@interface BoolExpressionViewController : UITableViewController

@property (nonatomic) id <BoolExpression> boolExpression;
@property NSMutableArray * typesIndex;
@property NSMutableArray * types;
@property NSMutableArray * elements;
@property NSMutableArray * strings;

@end
