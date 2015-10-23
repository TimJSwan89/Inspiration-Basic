//
//  BoolRandom.h
//  InspirationBasic
//
//  Created by Timothy Swan on 8/11/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoolExpression.h"

@interface BoolRandom : NSObject<BoolExpression>

- (id) init;

- (bool) evaluateAgainst: (EnvironmentModel *) environment;

- (void) accept:(id <ExpressionVisitor>) visitor;

@end