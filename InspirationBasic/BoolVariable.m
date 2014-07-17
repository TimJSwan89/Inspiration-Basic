//
//  BoolVariable.m
//  InspirationBasic
//
//  Created by Timothy Swan on 5/31/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "BoolVariable.h"
#import "BoolValue.h"

@implementation BoolVariable

- (id) initWithVariable:(NSString *) variable {
    if (self = [super init]) {
        self.variable = variable;
    }
    return self;
}

- (BoolValue *)evaluateAgainst:(EnvironmentModel *)environment {
    if ([ProgramException checkException:self withEnvironment:environment andIdentifier:@"BoolVariable"])
        return nil;
    return (BoolValue *) [environment getValueFor:self.variable];
}

- (void) accept:(id <ExpressionVisitor>)visitor {
    [visitor visitBoolVariable:self];
}

@end