//
//  IntVariable.m
//  InspirationBasic
//
//  Created by Timothy Swan on 5/31/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "IntVariable.h"
#import "IntValue.h"

@implementation IntVariable

- (id) initWithVariable:(NSString *) variable {
    if (self = [super init]) {
        self.variable = variable;
    }
    return self;
}

- (int)evaluateAgainst:(EnvironmentModel *)environment {
    if ([ProgramException checkExceptionWithEnvironment:environment andIdentifier:@"IntVariable"])
        return 0;
    return [environment getIntFor:self.variable];
}

- (void) accept:(id <ExpressionVisitor>)visitor {
    [visitor visitIntVariable:self];
}

@end
