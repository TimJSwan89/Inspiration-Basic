//
//  IntRandom.m
//  InspirationBasic
//
//  Created by Timothy Swan on 8/11/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "IntRandom.h"
#import "IntValue.h"

@implementation IntRandom

- (id) initWith: (id <IntExpression>) expression {
    if (self = [super init]) {
        self.expression = expression;
    }
    return self;
}

-(int) evaluateAgainst:(EnvironmentModel *)environment {
    
    int theValue = [self.expression evaluateAgainst:environment];
    if (theValue < 0) {
        NSString * message = @"Random range must be positive.";
        environment.exception = [[ProgramException alloc] initWithMessage:message];
        return 0;
    }
    if ([ProgramException checkExceptionWithEnvironment:environment andIdentifier:@"IntRandom Expression"])
        return 0;
    
    return arc4random_uniform(theValue);
    
}

- (void) accept:(id <ExpressionVisitor>)visitor {
    [visitor visitIntRandom:self];
}

@end
