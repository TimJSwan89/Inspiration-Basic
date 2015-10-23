//
//  IfThenEndIf.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/2/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "IfThenEndIf.h"
#import "BoolValue.h"

@implementation IfThenEndIf

- (id) initWithIf: (id <BoolExpression>)expression Then: (StatementList *)thenStatements {
    if (self = [super init]) {
        self.expression = expression;
        self.thenStatements = thenStatements;
        thenStatements.parent = self;
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
    }
}

- (void) accept:(id <StatementVisitor>)visitor {
    [visitor visitIfThenEndIf:self];
}

@end
