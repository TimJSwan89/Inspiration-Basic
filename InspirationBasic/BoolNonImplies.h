//
//  BoolNonImplies.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/2/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoolExpression.h"

@interface BoolNonImplies : NSObject<BoolExpression>

@property (nonatomic) id <BoolExpression> expression1;
@property (nonatomic) id <BoolExpression> expression2;

- (id) initWith: (id <BoolExpression>) expression1 BoolNonImplies:(id <BoolExpression>) expression2;

- (BoolValue *) evaluateAgainst: (EnvironmentModel *) environment;

- (void) accept:(id <ExpressionVisitor>) visitor;

@end