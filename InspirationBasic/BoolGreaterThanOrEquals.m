//
//  BoolGreaterThanOrEquals.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/2/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "BoolGreaterThanOrEquals.h"
#import "BoolValue.h"
#import "IntValue.h"

@implementation BoolGreaterThanOrEquals

- (id) initWith: (id <IntExpression>) expression1 GreaterThanOrEquals:(id <IntExpression>) expression2 {
    if (self = [super init]) {
        self.expression1 = expression1;
        self.expression2 = expression2;
    }
    return self;
}

-(BoolValue *) evaluateAgainst:(EnvironmentModel *)environment {
    
    IntValue * firstValue = [self.expression1 evaluateAgainst:environment];
    if ([ProgramException checkException:firstValue withEnvironment:environment andIdentifier:@"BoolLessThanOrEquals Expression 1"])
        return nil;
    
    IntValue * secondValue = [self.expression2 evaluateAgainst:environment];
    if ([ProgramException checkException:secondValue withEnvironment:environment andIdentifier:@"BoolLessThanOrEquals Expression 2"])
        return nil;
    
    BOOL value = firstValue.value >= secondValue.value;
    return [[BoolValue alloc] initWithValue:value];
    
}

- (void) accept:(id <ExpressionVisitor>)visitor {
    [visitor visitBoolGreaterThanOrEquals:self];
}

@end