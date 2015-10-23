//
//  BoolArrayElement.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/3/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "BoolArrayElement.h"
#import "IntValue.h"

@implementation BoolArrayElement

- (id) initWithVariable:(NSString *) variable andIndexExpression:(id<IntExpression>)indexExpression {
    if (self = [super init]) {
        self.variable = variable;
        self.indexExpression = indexExpression;
    }
    return self;
}

- (bool)evaluateAgainst:(EnvironmentModel *)environment {
    int index = [self.indexExpression evaluateAgainst:environment];
    return [environment getBoolFor:self.variable atIndex:index];
}

- (void) accept:(id <ExpressionVisitor>)visitor {
    [visitor visitBoolArrayElement:self];
}

@end