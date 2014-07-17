//
//  IntNegation.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/2/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntExpression.h"

@interface IntNegation : NSObject<IntExpression>

@property (nonatomic) id <IntExpression> expression;

- (id) initWith: (id <IntExpression>) expression;

- (IntValue *) evaluateAgainst: (EnvironmentModel *) environment;

- (void) accept:(id <ExpressionVisitor>) visitor;

@end