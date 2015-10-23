//
//  IntNegation.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/2/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "IntNegation.h"
#import "IntValue.h"

@implementation IntNegation

- (id) initWith: (id <IntExpression>) expression {
    if (self = [super init]) {
        self.expression = expression;
    }
    return self;
}

-(int) evaluateAgainst:(EnvironmentModel *)environment {
    
    int theValue = [self.expression evaluateAgainst:environment];
    if ([ProgramException checkExceptionWithEnvironment:environment andIdentifier:@"IntNegation Expression"])
        return 0;
    
    return -theValue;
    
}

- (void) accept:(id <ExpressionVisitor>)visitor {
    [visitor visitIntNegation:self];
}

@end
