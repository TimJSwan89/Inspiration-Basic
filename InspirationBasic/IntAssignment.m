//
//  IntAssignment.m
//  InspirationBasic
//
//  Created by Timothy Swan on 5/28/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "IntAssignment.h"

@implementation IntAssignment

- (id) initWith:(NSString *)variable equals:(id <IntExpression>)expression {
    if (self = [super init]) {
        self.variable = variable;
        self.expression = expression;
    }
    return self;
}

- (void) executeAgainst:(EnvironmentModel *)environment {
    if (environment.exception)
        return;
    [environment setInt:[self.expression evaluateAgainst:environment] For:self.variable];
    if ([ProgramException checkExceptionWithEnvironment:environment andIdentifier:@"IntAssignment"])
        return;
}

- (void) accept:(id <StatementVisitor>)visitor {
    [visitor visitIntAssigment:self];
}

@end
