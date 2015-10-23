//
//  BoolAssignment.m
//  InspirationBasic
//
//  Created by Timothy Swan on 5/29/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "BoolAssignment.h"
#import "EnvironmentModel.h"

@implementation BoolAssignment

- (id) initWith:(NSString *)variable equals:(id <BoolExpression>)expression {
    if (self = [super init]) {
        self.variable = variable;
        self.expression = expression;
    }
    return self;
}

- (void) executeAgainst:(EnvironmentModel *)environment {
    if (environment.exception)
        return;
    [environment setBool:[self.expression evaluateAgainst:environment] For:self.variable];
    if ([ProgramException checkExceptionWithEnvironment:environment andIdentifier:@"BoolAssignment"])
        return;
    
}

- (void) accept:(id <StatementVisitor>)visitor {
    [visitor visitBoolAssigment:self];
}

@end