//
//  IntSum.m
//  InspirationBasic
//
//  Created by Timothy Swan on 5/31/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "IntSum.h"
#import "IntValue.h"

@implementation IntSum

- (id) initWith: (id <IntExpression>) expression1 plus:(id <IntExpression>) expression2 {
    if (self = [super init]) {
        self.expression1 = expression1;
        self.expression2 = expression2;
    }
    return self;
}

-(int) evaluateAgainst:(EnvironmentModel *)environment {
    
    int firstValue = [self.expression1 evaluateAgainst:environment];
    if ([ProgramException checkExceptionWithEnvironment:environment andIdentifier:@"IntSum Expression 1"])
        return 0;
    
    int secondValue = [self.expression2 evaluateAgainst:environment];
    if ([ProgramException checkExceptionWithEnvironment:environment andIdentifier:@"IntSum Expression 2"])
        return 0;
    
    int newValue = firstValue + secondValue;
    return newValue;
    
}

- (void) accept:(id <ExpressionVisitor>)visitor {
    [visitor visitIntSum:self];
}

@end
