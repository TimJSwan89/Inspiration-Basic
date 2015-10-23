//
//  BoolValue.m
//  InspirationBasic
//
//  Created by Timothy Swan on 5/28/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "BoolValue.h"

@implementation BoolValue: Value

- (id) initWithValue:(BOOL) value {
    if (self = [super init]) {
        self.value = value;
    }
    return self;
}

- (bool)evaluateAgainst:(EnvironmentModel *)environment{
    if ([ProgramException checkExceptionWithEnvironment:environment andIdentifier:@"BoolValue"])
        return false;
    return self.value;
}

- (void) accept:(id <ExpressionVisitor>)visitor {
    [visitor visitBoolValue:self];
}

@end
