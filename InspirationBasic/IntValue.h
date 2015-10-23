//
//  IntValue.h
//  InspirationBasic
//
//  Created by Timothy Swan on 5/28/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Value.h"
#import "IntExpression.h"

@interface IntValue : Value <IntExpression>

@property (nonatomic) int value;

- (id) initWithValue:(int) value;

- (int) evaluateAgainst:(EnvironmentModel *)environment;

- (void) accept:(id <ExpressionVisitor>)visitor;

@end
