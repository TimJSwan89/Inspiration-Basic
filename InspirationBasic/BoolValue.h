//
//  BoolValue.h
//  InspirationBasic
//
//  Created by Timothy Swan on 5/28/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Value.h"
#import "BoolExpression.h"

@interface BoolValue : Value <BoolExpression>

@property (nonatomic) BOOL value;

- (id) initWithValue:(BOOL) value;

- (bool) evaluateAgainst:(EnvironmentModel *)environment;

- (void) accept:(id <ExpressionVisitor>)visitor;

@end
