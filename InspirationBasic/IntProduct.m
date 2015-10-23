//
//  IntProduct.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/2/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "IntProduct.h"
#import "IntValue.h"

@implementation IntProduct

- (id) initWith: (id <IntExpression>) expression1 times:(id <IntExpression>) expression2 {
    if (self = [super init]) {
        self.expression1 = expression1;
        self.expression2 = expression2;
    }
    return self;
}

-(int) evaluateAgainst:(EnvironmentModel *)environment {
    
    int firstValue = [self.expression1 evaluateAgainst:environment];
    if ([ProgramException checkExceptionWithEnvironment:environment andIdentifier:@"IntProduct Expression 1"])
        return 0;
    
    int secondValue = [self.expression2 evaluateAgainst:environment];
    if ([ProgramException checkExceptionWithEnvironment:environment andIdentifier:@"IntProduct Expression 2"])
        return 0;
    
    int newValue = firstValue * secondValue;
    return newValue;
    
}

- (void) accept:(id <ExpressionVisitor>)visitor {
    [visitor visitIntProduct:self];
}

@end
