//
//  IntRemainder.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/2/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "IntRemainder.h"
#import "IntValue.h"

@implementation IntRemainder

- (id) initWith: (id <IntExpression>) expression1 dividedBy:(id <IntExpression>) expression2 {
    if (self = [super init]) {
        self.expression1 = expression1;
        self.expression2 = expression2;
    }
    return self;
}

-(int) evaluateAgainst:(EnvironmentModel *)environment {
    
    IntValue * numeratorValue = [self.expression1 evaluateAgainst:environment];
    if ([ProgramException checkException:numeratorValue withEnvironment:environment andIdentifier:@"IntRemainder Expression 1"])
        return 0;
    int numerator = numeratorValue.value;
    
    IntValue * denominatorValue = [self.expression2 evaluateAgainst:environment];
    if ([ProgramException checkException:denominatorValue withEnvironment:environment andIdentifier:@"IntRemainder Expression 2"])
        return 0;
    int denominator = denominatorValue.value;
    
    if (denominator == 0) {
        NSString * message = @"The remainder of the division of an expression numerator with the value ";
        message = [message stringByAppendingString:[[NSNumber numberWithInt:numerator] stringValue]];
        message = [message stringByAppendingString:@" by an expression denominator with the value 0 does not exist."];
        environment.exception = [[ProgramException alloc] initWithMessage:message];
        return 0;
    }
    
    int newValue = numerator % denominator;
    return newValue;
    
}

- (void) accept:(id <ExpressionVisitor>)visitor {
    [visitor visitIntRemainder:self];
}

@end
