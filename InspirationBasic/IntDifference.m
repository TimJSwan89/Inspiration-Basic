//
//  IntDifference.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/2/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "IntDifference.h"
#import "IntValue.h"

@implementation IntDifference

- (id) initWith: (id <IntExpression>) expression1 minus:(id <IntExpression>) expression2 {
    if (self = [super init]) {
        self.expression1 = expression1;
        self.expression2 = expression2;
    }
    return self;
}

-(int) evaluateAgainst:(EnvironmentModel *)environment {
    
    IntValue * firstValue = [self.expression1 evaluateAgainst:environment];
    if ([ProgramException checkException:firstValue withEnvironment:environment andIdentifier:@"IntDifference Expression 1"])
        return 0;
    
    IntValue * secondValue = [self.expression2 evaluateAgainst:environment];
    if ([ProgramException checkException:secondValue withEnvironment:environment andIdentifier:@"IntDifference Expression 2"])
        return 0;
    
    int newValue = firstValue.value - secondValue.value;
    return newValue;
    
}

- (void) accept:(id <ExpressionVisitor>)visitor {
    [visitor visitIntDifference:self];
}

@end
