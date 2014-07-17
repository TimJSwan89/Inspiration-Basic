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

- (id) initWithIf: (id <BoolExpression>)expression Then: (StatementList *)thenStatements Else: (StatementList *)elseStatements andParent:(id <Statement>) parent {
    if (self = [super init]) {
        self.expression = expression;
        self.thenStatements = thenStatements;
        thenStatements.parent = self;
        self.elseStatements = elseStatements;
        elseStatements.parent = self;
        self.parent = parent;
    }
    return self;
}

-(void) executeAgainst:(EnvironmentModel *)environment {
    if (environment.exception)
        return;
    if ([self.expression evaluateAgainst:environment].value)
        [self.thenStatements executeAgainst:environment];
    else
        [self.elseStatements executeAgainst:environment];
}

- (void) accept:(id <StatementVisitor>)visitor {
    [visitor visitIfThenElseEndIf:self];
}

@end
