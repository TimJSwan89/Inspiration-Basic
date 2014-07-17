//
//  IntArrayElementAssignment.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/4/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "IntArrayElementAssignment.h"
#import "IntArrayElement.h"
#import "IntValue.h"

@implementation IntArrayElementAssignment

- (id) initWith:(IntArrayElement *)element equals:(id <IntExpression>)expression andParent:(id <Statement>) parent {
    if (self = [super init]) {
        self.variable = element.variable;
        self.indexExpression = element.indexExpression;
        self.expression = expression;
        self.parent = parent;
    }
    return self;
}

- (void) executeAgainst:(EnvironmentModel *)environment {
    if (environment.exception)
        return;
    [environment setValue:(Value*)[self.expression evaluateAgainst:environment] For:self.variable atIndex:[self.indexExpression evaluateAgainst:environment].value];
}

- (void) accept:(id <StatementVisitor>)visitor {
    [visitor visitIntArrayElementAssigment:self];
}

@end
