//
//  IntExpressionViewController.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/18/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntExpression.h"

@interface IntExpressionViewController : UITableViewController

@property (nonatomic) id <IntExpression> intExpression;
@property NSMutableArray * typesIndex;
@property NSMutableArray * types;
@property NSMutableArray * elements;
@property NSMutableArray * strings;

@end
