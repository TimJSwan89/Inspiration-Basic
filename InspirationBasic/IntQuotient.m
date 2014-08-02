//
//  IntQuotient.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/2/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "IntQuotient.h"
#import "IntValue.h"
#import "ProgramException.h"

@implementation IntQuotient

- (id) initWith: (id <IntExpression>) expression1 dividedBy:(id <IntExpression>) expression2 {
    if (self = [super init]) {
        self.expression1 = expression1;
        self.expression2 = expression2;
    }
    return self;
}

-(IntValue *) evaluateAgainst:(EnvironmentModel *)environment {
    
    IntValue * numeratorValue = [self.expression1 evaluateAgainst:environment];
    if ([ProgramException checkException:numeratorValue withEnvironment:environment andIdentifier:@"IntQuotient Expression 1"])
        return nil;
    int numerator = numeratorValue.value;
    
    IntValue * denominatorValue = [self.expression2 evaluateAgainst:environment];
    if ([ProgramException checkException:denominatorValue withEnvironment:environment andIdentifier:@"IntQuotient Expression 2"])
        return nil;
    int denominator = denominatorValue.value;
    
    if (denominator == 0) {
        NSString * message = @"The quotient of the division of an expression numerator with the value ";
        message = [message stringByAppendingString:[[NSNumber numberWithInt:numerator] stringValue]];
        message = [message stringByAppendingString:@" by an expression denominator with the value 0 does not exist."];
        environment.exception = [[ProgramException alloc] initWithMessage:message];
        return nil;
    }
    
    int newValue = numerator / denominator;
    return [[IntValue alloc] initWithValue:newValue];
    
}

- (void) accept:(id <ExpressionVisitor>)visitor {
    [visitor visitIntQuotient:self];
}

@end
