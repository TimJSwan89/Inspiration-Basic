//
//  IntRandom.h
//  InspirationBasic
//
//  Created by Timothy Swan on 8/11/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntExpression.h"

@interface IntRandom : NSObject<IntExpression>

@property (nonatomic) id <IntExpression> expression;

- (id) initWith: (id <IntExpression>) expression;

- (int) evaluateAgainst: (EnvironmentModel *) environment;

- (void) accept:(id <ExpressionVisitor>) visitor;

@end