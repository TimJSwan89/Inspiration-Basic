//
//  IfThenElseEndIf.m
//  InspirationBasic
//
//  Created by Timothy Swan on 5/31/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "IfThenElseEndIf.h"
#import "BoolValue.h"

@implementation IfThenElseEndIf

- (id) initWithIf: (id <BoolExpression>)expression Then: (StatementList *)thenStatements Else: (StatementList *)elseStatements {
    if (self = [super init]) {
        self.expression = expression;
        self.thenStatements = thenStatements;
        thenStatements.parent = self;
        self.elseStatements = elseStatements;
        elseStatements.parent = self;
    }
    return self;
}

-(void) executeAgainst:(EnvironmentModel *)environment {
    if ([ProgramException checkExceptionWithEnvironment:environment andIdentifier:@"PreIf"])
        return;
    if ([self.expression evaluateAgainst:environment]) {
        if ([ProgramException checkExceptionWithEnvironment:environment andIdentifier:@"IfCheck"])
            return;
        [self.thenStatements executeAgainst:environment];
        if ([ProgramException checkExceptionWithEnvironment:environment andIdentifier:@"IfThen"])
            return;
    } else {
        if ([ProgramException checkExceptionWithEnvironment:environment andIdentifier:@"IfCheck"])
            return;
        [self.elseStatements executeAgainst:environment];
        if ([ProgramException checkExceptionWithEnvironment:environment andIdentifier:@"IfElse"])
            return;
    }
}

- (void) accept:(id <StatementVisitor>)visitor {
    [visitor visitIfThenElseEndIf:self];
}

@end
