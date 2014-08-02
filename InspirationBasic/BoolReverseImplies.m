//
//  BoolReverseImplies.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/2/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "BoolReverseImplies.h"
#import "BoolValue.h"

@implementation BoolReverseImplies

- (id) initWith: (id <BoolExpression>) expression1 BoolReverseImplies:(id <BoolExpression>) expression2 {
    if (self = [super init]) {
        self.expression1 = expression1;
        self.expression2 = expression2;
    }
    return self;
}

-(bool) evaluateAgainst:(EnvironmentModel *)environment {
    
    BoolValue * firstValue = [self.expression1 evaluateAgainst:environment];
    if ([ProgramException checkException:firstValue withEnvironment:environment andIdentifier:@"BoolReverseImplies Expression 1"])
        return false;
    
    BoolValue * secondValue = [self.expression2 evaluateAgainst:environment];
    if ([ProgramException checkException:secondValue withEnvironment:environment andIdentifier:@"BoolReverseImplies Expression 2"])
        return false;
    
    BOOL newValue = firstValue.value || !secondValue.value;
    return newValue;
    
}

- (void) accept:(id <ExpressionVisitor>)visitor {
    [visitor visitBoolReverseImplies:self];
}

@end