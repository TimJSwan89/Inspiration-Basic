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

- (id) initWithWhile: (id <BoolExpression>)expression Do: (StatementList *)loopStatements andParent:(id <Statement>) parent {
    if (self = [super init]) {
        self.expression = expression;
        self.loopStatements = loopStatements;
        loopStatements.parent = self;
        self.parent = parent;
    }
    return self;
}

-(void) executeAgainst:(EnvironmentModel *)environment {
    if (environment.exception)
        return;
    while ([self.expression evaluateAgainst:environment].value)
        [self.loopStatements executeAgainst:environment];
}

- (void) accept:(id <StatementVisitor>)visitor {
    [visitor visitWhileEndWhile:self];
}

@end
