//
//  IntValue.m
//  InspirationBasic
//
//  Created by Timothy Swan on 5/28/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "IntValue.h"
#import "Value.h"
#import "ProgramException.h"

@implementation IntValue: Value

- (id) initWithValue:(int) value {
    if (self = [super init]) {
        self.value = value;
    }
    return self;
}

- (IntValue *)evaluateAgainst:(EnvironmentModel *)environment {
    if ([ProgramException checkException:self withEnvironment:environment andIdentifier:@"IntValue"])
        return nil;
    return self;
}

- (void) accept:(id <ExpressionVisitor>)visitor {
    [visitor visitIntValue:self];
}

@end
