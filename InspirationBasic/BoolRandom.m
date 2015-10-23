//
//  BoolRandom.m
//  InspirationBasic
//
//  Created by Timothy Swan on 8/11/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "BoolRandom.h"
#import "BoolValue.h"

@implementation BoolRandom

- (id) init {
    if (self = [super init]) {
    }
    return self;
}

-(bool) evaluateAgainst:(EnvironmentModel *)environment {
    return (arc4random_uniform(2));
}

- (void) accept:(id <ExpressionVisitor>)visitor {
    [visitor visitBoolRandom:self];
}

@end