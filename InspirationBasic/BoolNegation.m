//
//  BoolNegation.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/2/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "BoolNegation.h"
#import "BoolValue.h"

@implementation BoolNegation

- (id) initWith: (id <BoolExpression>) expression {
    if (self = [super init]) {
        self.expression = expression;
    }
    return self;
}

-(bool) evaluateAgainst:(EnvironmentModel *)environment {
    
    BoolValue * theValue = [self.expression evaluateAgainst:environment];
    if ([ProgramException checkException:theValue withEnvironment:environment andIdentifier:@"BoolNegation Expression"])
        return false;

    return !theValue.value;
    
}

- (void) accept:(id <ExpressionVisitor>)visitor {
    [visitor visitBoolNegation:self];
}

@end