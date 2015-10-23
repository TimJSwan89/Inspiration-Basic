//
//  BoolLessThanOrEquals.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/2/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "BoolLessThanOrEquals.h"
#import "BoolValue.h"
#import "IntValue.h"

@implementation BoolLessThanOrEquals

- (id) initWith: (id <IntExpression>) expression1 LessThanOrEquals:(id <IntExpression>) expression2 {
    if (self = [super init]) {
        self.expression1 = expression1;
        self.expression2 = expression2;
    }
    return self;
}

-(bool) evaluateAgainst:(EnvironmentModel *)environment {
    
    int firstValue = [self.expression1 evaluateAgainst:environment];
    if ([ProgramException checkExceptionWithEnvironment:environment andIdentifier:@"BoolLessThanOrEquals Expression 1"])
        return false;
    
    int secondValue = [self.expression2 evaluateAgainst:environment];
    if ([ProgramException checkExceptionWithEnvironment:environment andIdentifier:@"BoolLessThanOrEquals Expression 2"])
        return false;
    
    BOOL value = firstValue <= secondValue;
    return value;
    
}

- (void) accept:(id <ExpressionVisitor>)visitor {
    [visitor visitBoolLessThanOrEquals:self];
}

@end