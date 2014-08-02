//
//  IntSum.h
//  InspirationBasic
//
//  Created by Timothy Swan on 5/31/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntExpression.h"

@interface IntSum : NSObject<IntExpression>

@property (nonatomic) id <IntExpression> expression1;
@property (nonatomic) id <IntExpression> expression2;

- (id) initWith: (id <IntExpression>) expression1 plus:(id <IntExpression>) expression2;

- (int) evaluateAgainst: (EnvironmentModel *) environment;

- (void) accept:(id <ExpressionVisitor>) visitor;

@end