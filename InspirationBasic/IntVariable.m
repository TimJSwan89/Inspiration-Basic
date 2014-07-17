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

- (IntValue *)evaluateAgainst:(EnvironmentModel *)environment {
    if ([ProgramException checkException:self withEnvironment:environment andIdentifier:@"IntVariable"])
        return nil;
    return (IntValue *) [environment getValueFor:self.variable];
}

- (void) accept:(id <ExpressionVisitor>)visitor {
    [visitor visitIntVariable:self];
}

@end
