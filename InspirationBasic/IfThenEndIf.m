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

- (id) initWithIf: (id <BoolExpression>)expression Then: (StatementList *)thenStatements andParent:(id <Statement>) parent {
    if (self = [super init]) {
        self.expression = expression;
        self.thenStatements = thenStatements;
        thenStatements.parent = self;
        self.parent = parent;
    }
    return self;
}

-(void) executeAgainst:(EnvironmentModel *)environment {
    if (environment.exception)
        return;
    if ([self.expression evaluateAgainst:environment].value)
        [self.thenStatements executeAgainst:environment];
}

- (void) accept:(id <StatementVisitor>)visitor {
    [visitor visitIfThenEndIf:self];
}

@end
