//
//  BoolExpression.h
//  InspirationBasic
//
//  Created by Timothy Swan on 5/28/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EnvironmentModel.h"
#import "ExpressionVisitor.h"
@class BoolValue;

@protocol BoolExpression

- (BoolValue *)evaluateAgainst:(EnvironmentModel *)environment;

- (void) accept: (id <ExpressionVisitor>) visitor;

@end
