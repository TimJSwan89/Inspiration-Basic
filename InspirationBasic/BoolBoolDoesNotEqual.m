//
//  BoolBoolDoesNotEqual.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/2/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "BoolBoolDoesNotEqual.h"
#import "BoolValue.h"

@implementation BoolBoolDoesNotEqual

- (id) initWith: (id <BoolExpression>) expression1 BoolBoolDoesNotEqual:(id <BoolExpression>) expression2 {
    if (self = [super init]) {
        self.expression1 = expression1;
        self.expression2 = expression2;
    }
    return self;
}

-(BoolValue *) evaluateAgainst:(EnvironmentModel *)environment {
    
    BoolValue * firstValue = [self.expression1 evaluateAgainst:environment];
    if ([ProgramException checkException:firstValue withEnvironment:environment andIdentifier:@"BoolBoolDoesNotEqual Expression 1"])
        return nil;
    
    BoolValue * secondValue = [self.expression2 evaluateAgainst:environment];
    if ([ProgramException checkException:secondValue withEnvironment:environment andIdentifier:@"BoolBoolDoesNotEqual Expression 2"])
        return nil;
    
    BOOL newValue = firstValue.value != secondValue.value;
    return [[BoolValue alloc] initWithValue:newValue];
    
}

- (void) accept:(id <ExpressionVisitor>)visitor {
    [visitor visitBoolBoolDoesNotEqual:self];
}

@end