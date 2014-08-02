//
//  BoolGreaterThan.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/2/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "BoolGreaterThan.h"
#import "BoolValue.h"
#import "IntValue.h"

@implementation BoolGreaterThan

- (id) initWith: (id <IntExpression>) expression1 GreaterThan:(id <IntExpression>) expression2 {
    if (self = [super init]) {
        self.expression1 = expression1;
        self.expression2 = expression2;
    }
    return self;
}

-(bool) evaluateAgainst:(EnvironmentModel *)environment {
    
    IntValue * firstValue = [self.expression1 evaluateAgainst:environment];
    if ([ProgramException checkException:firstValue withEnvironment:environment andIdentifier:@"BoolGreaterThan Expression 1"])
        return false;
    
    IntValue * secondValue = [self.expression2 evaluateAgainst:environment];
    if ([ProgramException checkException:secondValue withEnvironment:environment andIdentifier:@"BoolGreaterThan Expression 2"])
        return false;
    
    BOOL value = firstValue.value > secondValue.value;
    return value;
    
}

- (void) accept:(id <ExpressionVisitor>)visitor {
    [visitor visitBoolGreaterThan:self];
}

@end