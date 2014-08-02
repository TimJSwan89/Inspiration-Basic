//
//  BoolNegation.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/2/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoolExpression.h"

@interface BoolNegation : NSObject<BoolExpression>

@property (nonatomic) id <BoolExpression> expression;

- (id) initWith: (id <BoolExpression>) expression;

- (bool) evaluateAgainst: (EnvironmentModel *) environment;

- (void) accept:(id <ExpressionVisitor>) visitor;

@end