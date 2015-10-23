//
//  BoolArrayElementAssignment.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/4/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "BoolArrayElementAssignment.h"
#import "BoolArrayElement.h"
#import "IntValue.h"
//#import "EnvironmentModel.h"

@implementation BoolArrayElementAssignment

- (id) initWith:(BoolArrayElement *)element equals:(id <BoolExpression>)expression {
    if (self = [super init]) {
        self.variable = element.variable;
        self.indexExpression = element.indexExpression;
        self.expression = expression;
    }
    return self;
}

- (void) executeAgainst:(EnvironmentModel *)environment {
    if (environment.exception)
        return;
    [environment setBool:[self.expression evaluateAgainst:environment] For:self.variable atIndex:[self.indexExpression evaluateAgainst:environment]];
    
}

- (void) accept:(id <StatementVisitor>)visitor {
    [visitor visitBoolArrayElementAssignment:self];
}

@end