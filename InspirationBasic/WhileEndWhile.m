//
//  WhileEndWhile.m
//  InspirationBasic
//
//  Created by Timothy Swan on 5/31/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "WhileEndWhile.h"
#import "BoolValue.h"

@implementation WhileEndWhile

- (id) initWithWhile: (id <BoolExpression>)expression Do: (StatementList *)loopStatements {
    if (self = [super init]) {
        self.expression = expression;
        self.loopStatements = loopStatements;
        loopStatements.parent = self;
    }
    return self;
}

-(void) executeAgainst:(EnvironmentModel *)environment {
    if ([ProgramException checkExceptionWithEnvironment:environment andIdentifier:@"PreWhileLoop"])
        return;
    while ([self.expression evaluateAgainst:environment]) {
        @autoreleasepool {
            if ([ProgramException checkExceptionWithEnvironment:environment andIdentifier:@"WhileCheck"])
                return;
            [self.loopStatements executeAgainst:environment];
            if ([ProgramException checkExceptionWithEnvironment:environment andIdentifier:@"WhileLoop"])
                return;
        }
    }
}

- (void) accept:(id <StatementVisitor>)visitor {
    [visitor visitWhileEndWhile:self];
}

@end
