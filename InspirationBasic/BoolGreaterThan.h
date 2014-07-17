//
//  BoolGreaterThan.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/2/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoolExpression.h"
#import "IntExpression.h"

@interface BoolGreaterThan : NSObject<BoolExpression>

@property (nonatomic) id <IntExpression> expression1;
@property (nonatomic) id <IntExpression> expression2;

- (id) initWith: (id <IntExpression>) expression1 GreaterThan:(id <IntExpression>) expression2;

- (BoolValue *) evaluateAgainst: (EnvironmentModel *) environment;

- (void) accept:(id <ExpressionVisitor>) visitor;

@end